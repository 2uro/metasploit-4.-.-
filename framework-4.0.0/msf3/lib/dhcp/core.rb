=begin
**
** core.rb
** 02/OCT/2007
** ETD-Software
**	- Daniel Martin Gomez <etd[-at-]nomejortu.com>
**
** Desc:
**	 This file provides a set of classes to work with the DHCP protocol. They
** provide low level access to all the fields and internals of the protocol.
**
** See the provided rdoc comments for further information.
**
** Version:
**	v1.0 [02/October/2007]: first released
**	v1.1 [31/October/2007]: file moved under /dhcp/ directory and renamed to
**													core.rb. Now it only contains core classes to
**													encapsulate DHCP messages
**
** License:
**	 Please see dhcp.rb or LICENSE.txt for copyright and licensing information.
**
=end

module DHCP
	# -------------------------------------------------------------- dhcp messages
	class Message
		attr_accessor :op, :htype, :hlen, :hops
		attr_accessor :xid
		attr_accessor :secs, :flags
		attr_accessor :ciaddr, :yiaddr, :siaddr, :giaddr, :chaddr
		attr_accessor :options

		# chaddr = mac address
		# yiaddr = offered address

		alias == eql?

		def Message.from_udp_payload(data)
			values = data.unpack('C4Nn2N4C16C192NC*')

			params = {
				:op => values.shift,
				:htype => values.shift,
				:hlen => values.shift,
				:hops => values.shift,

				:xid => values.shift,
				:secs => values.shift,
				:flags => values.shift,
				:ciaddr => values.shift,
				:yiaddr => values.shift,
				:siaddr => values.shift,
				:giaddr => values.shift,
				:chaddr => values.slice!(0..15)
			}

			# sname and file
			not_used = values.slice!(0..191)

			return nil unless ($DHCP_MAGIC == values.shift)

			#default message class
			msg_class = Message
			#default option class
			opt_class = Option

			params[:options] = []

			next_opt = values.shift
			while(next_opt != $DHCP_END)
				p = {
					:type => next_opt,
					:len => values.shift
				}
				p[:payload] = values.slice!(0..p[:len]-1)

				# check what is the type of dhcp option
				opt_class = $DHCP_MSG_OPTIONS[p[:type]]
				if(opt_class.nil?)
					puts '-------------------- nil opt_class please further investigate!!'
					puts p[:type]
					puts '-------------------- /'
					opt_class == Option
				end
				if (opt_class == MessageTypeOption)
					msg_class = $DHCP_MSG_CLASSES[p[:payload].first]
				end
				params[:options] << opt_class.new(p)
				next_opt = values.shift
			end
			
			if(msg_class.nil?)
				puts '-------------------- nil msg_class please further investigate!!'
				p params[:options]
				puts '-------------------- /'
				opt_class == Option
			end
			msg_class.new(params)
		end

		def initialize(params = {})

			# message operation and options. We need at least an operation and a
			# MessageTypeOption to create a DHCP message!!
			if (([:op, :options]	& params.keys).size != 2)
				raise ArgumentError('you need to specify at least values for :op and :options')
			end

			self.op = params[:op]
			self.options = params[:options]

			found = false
			self.options.each do |opt|
				next unless opt.class == MessageTypeOption
				found = true
			end
			raise ArgumentError(':options must include a MessageTypeOption') unless found

			#hardware type and length of the hardware address
			self.htype = params.fetch(:htype, $DHCP_HTYPE_ETHERNET)
			self.hlen = params.fetch(:hlen, $DHCP_HLEN_ETHERNET)

			# client sets to zero. relay agents may modify
			self.hops = params.fetch(:hops, 0x00)

			# initialize a random transaction ID
			self.xid	= params.fetch(:xid, rand(2**32))

			# seconds elapsed, flags
			self.secs = params.fetch(:secs, 0x0000)
			self.flags = params.fetch(:flags, 0x0000)

			# client, you, next server	and relay agent addresses
			self.ciaddr = params.fetch(:ciaddr, 0x00000000)
			self.yiaddr = params.fetch(:yiaddr, 0x00000000)
			self.siaddr = params.fetch(:siaddr, 0x00000000)
			self.giaddr = params.fetch(:giaddr, 0x00000000)

			if (params.key?(:chaddr))
				mac = ""
				if params[:chaddr] =~ /^([0-9a-f]{2}([:-]|$)){6}$/i
					mac = params[:chaddr].chomp.strip.gsub(/:/,'')
				elsif params[:chaddr] =~ /^[0-9a-f]{12}$/i
					mac = params[:chaddr]
				elsif params[:chaddr].size == 16
					# This is the default assignment that came with the library
					self.chaddr = params[:chaddr]
				else
					raise 'Invalid MAC address passed'
				end

				if mac != ""
					self.chaddr = [mac].pack('H*').unpack('CCCCCC')
					self.chaddr += [0x00]*(16-self.chaddr.size)
				end
			else
# Failure point, location of ifconfig not always set

				mac = `/sbin/ifconfig | grep HWaddr | cut -c39- | head -1`.chomp.strip.gsub(/:/,'')
				self.chaddr = [mac].pack('H*').unpack('CCCCCC')
				self.chaddr += [0x00]*(16-self.chaddr.size)
			end


		end

		def pack()
			out = [
			self.op, self.htype, self.hlen, self.hops,
			self.xid,
			self.secs, self.flags,
			self.ciaddr,
			self.yiaddr,
			self.siaddr,
			self.giaddr
			].pack('C4Nn2N4')

			out << self.chaddr.pack('C*')


			# sname and file
			out << ([0x00]*192).pack('C192')

			out << [$DHCP_MAGIC].pack('N')
			self.options.each do |option|
				out << option.pack
			end
			out << [$DHCP_END].pack('C')

			# add padding up to 300 bytes
			if out.size < 300
				out << ([$DHCP_PAD]*(300-out.size)).pack('C*')
			end
			return out
		end

		def eql?(obj)
			# objects must be of the same class
			return false unless (self.class == obj.class)

			vars1 = self.instance_variables

			# first make sure that the :options var is equal
			opt1 = self.instance_variable_get('@options')
			opt2 = obj.instance_variable_get('@options')

			return false unless opt1.eql?(opt2)
			vars1.delete('@options')

			# check all the other instance vairables
			vars1.each do |var|
				return false unless (self.instance_variable_get(var) == obj.instance_variable_get(var))
			end

			return true
		end

		def offered_ip
			return [self.yiaddr].pack('N').unpack('C4').join('.')
		end

		def to_s
			out = "DHCP Message\r\n"
			out << "\tFIELDS:\r\n"
			out << "\t\tTransaction ID = #{self.xid}\r\n"
			out << "\t\tClient IP address = #{[self.ciaddr].pack('N').unpack('C4').join('.')}\r\n"
			out << "\t\tYour IP address = #{[self.yiaddr].pack('N').unpack('C4').join('.')}\r\n"
			out << "\t\tNext server IP address = #{[self.siaddr].pack('N').unpack('C4').join('.')}\r\n"
			out << "\t\tRelay agent IP address = #{[self.giaddr].pack('N').unpack('C4').join('.')}\r\n"
			out << "\t\tHardware address = #{self.chaddr.slice(0..(self.hlen-1)).collect do |b| b.to_s(16).upcase.rjust(2,'0') end.join(':')}\r\n"
			out << "\tOPT:\r\n"
			self.options.each do |opt|
				out << "\t\t #{opt.to_s}\r\n"
			end
			return out
		end
	end

	# Client broadcast to locate available servers.
	class Discover < Message
		def initialize(params={})
			params[:op] = $DHCP_OP_REQUEST
			# if an :options field is provided, we use it, otherwise, a default is set
			params[:options] = params.fetch(:options, [MessageTypeOption.new, ParameterRequestListOption.new])
			super(params)
		end
	end

	# Server to client in response to DHCPDISCOVER with offer of configuration
	# parameters.
	#
	# By default an ACK message will contain a Server Identifier (0.0.0.0) and
	# a Domain Name ('nomejortu.com') option.
	class Offer < Message
		def initialize(params={})
			params[:op] = $DHCP_OP_REPLY
			params[:options] = params.fetch(:options, [
			MessageTypeOption.new({:payload=>[$DHCP_MSG_OFFER]}),
			ServerIdentifierOption.new,
			DomainNameOption.new
			])
			super(params)
		end
	end

	# Client message to servers either (a) requesting offered parameters from one
	# server and implicitly declining offers from all others, (b) confirming
	# correctness of previously allocated address after, e.g., system reboot, or
	# (c) extending the lease on a particular network address.
	class Request < Message
		def initialize(params={})
			params[:op] = $DHCP_OP_REQUEST
			#params[:options] = params.fetch(:options, [MessageTypeOption.new({:payload=>[$DHCP_MSG_REQUEST]}), ParameterRequestListOption.new, RequestedIPAddressOption.new({:payload=>[192,168,0,2]})])
			params[:options] = params.fetch(:options, [MessageTypeOption.new({:payload=>[$DHCP_MSG_REQUEST]}), ParameterRequestListOption.new])
			super(params)
		end
	end

	#
	#	 DHCPDECLINE	-	Client to server indicating network address is already
	#									 in use.

	# Server to client with configuration parameters, including committed network
	# address.
	#
	# By default an ACK message will contain a Server Identifier (0.0.0.0) and
	# a Domain Name ('nomejortu.com') option.
	class ACK < Message
		def initialize(params={})
			params[:op] = $DHCP_OP_REPLY
			params[:options] = params.fetch(:options, [
			MessageTypeOption.new({:payload=>[$DHCP_MSG_ACK]}),
			ServerIdentifierOption.new,
			DomainNameOption.new
			])
			super(params)
		end
	end

	#	 DHCPNAK			-	Server to client indicating client's notion of network
	#									 address is incorrect (e.g., client has moved to new
	#									 subnet) or client's lease as expired

	# Client to server relinquishing network address and cancelling remaining
	# lease.
	#
	# By default an ACK message will contain a Server Identifier (0.0.0.0)
	class Release < Message
		def initialize(params={})
			params[:op] = $DHCP_OP_REQUEST
			params[:options] = params.fetch(:options, [
			MessageTypeOption.new({:payload=>[$DHCP_MSG_RELEASE]}),
			ServerIdentifierOption.new
			])
			super(params)
		end
	end

	class NACK < Message
		def initialize(params={})
			params[:op] = $DHCP_OP_REQUEST
			params[:options] = params.fetch(:options, [
			MessageTypeOption.new({:payload=>[$DHCP_MSG_NACK]}),
		#	ServerIdentifierOption.new
			])
			super(params)
		end
	end

	# Client to server, asking only for local configuration parameters; client
	# already has externally configured network address.
	class Inform < Message
		def initialize(params={})
			params[:op] = $DHCP_OP_REQUEST
			params[:options] = params.fetch(:options, [MessageTypeOption.new({:payload=>[$DHCP_MSG_INFORM]}), ParameterRequestListOption.new])
			super(params)
		end
	end

	# ------------------------------------ map from values of fields to class names

	$DHCP_MSG_CLASSES = {
		$DHCP_MSG_DISCOVER	=> Discover,
		$DHCP_MSG_OFFER		 => Offer,
		$DHCP_MSG_REQUEST	 => Request,
		#		$DHCP_MSG_DECLINE=		 0x04
		$DHCP_MSG_ACK			 => ACK,
		$DHCP_MSG_NACK	=> NACK,
		$DHCP_MSG_RELEASE	 => Release,
		$DHCP_MSG_INFORM		=> Inform
	}
end
