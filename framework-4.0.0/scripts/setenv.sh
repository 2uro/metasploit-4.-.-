#!/bin/sh
echo $LD_LIBRARY_PATH | egrep "/opt/framework-4.0.0/common" > /dev/null
if [ $? -ne 0 ] ; then
PATH="/opt/framework-4.0.0/java/bin:/opt/framework-4.0.0/ruby/bin:/opt/framework-4.0.0/postgresql/bin:/opt/framework-4.0.0/bin:/opt/framework-4.0.0/common/bin:$PATH"
export PATH
LD_LIBRARY_PATH="/opt/framework-4.0.0/java/lib:/opt/framework-4.0.0/ruby/lib:/opt/framework-4.0.0/postgresql/lib:/opt/framework-4.0.0/lib:/opt/framework-4.0.0/common/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH
fi

##### NMAP ENV #####
NMAPDIR="/opt/framework-4.0.0/share/nmap"
export NMAPDIR

##### JAVA ENV #####
JAVA_HOME="/opt/framework-4.0.0/java"
JAVALIB="/opt/framework-4.0.0/java/lib"
export JAVA_HOME
export JAVALIB
##### RUBY ENV #####
# Don't override GEM_PATH so users can install gems for the system ruby and
# they at least have a chance of working with ours
GEM_HOME="/opt/framework-4.0.0/ruby/lib/ruby/gems/1.9.1"
RUBY_HOME="/opt/framework-4.0.0/ruby"
RUBYLIB="/opt/framework-4.0.0/ruby/lib:/opt/framework-4.0.0/ruby/lib/ruby:/opt/framework-4.0.0/ruby/lib/ruby/1.9.1:/opt/framework-4.0.0/ruby/lib/ruby/1.9.1/i686-linux:/opt/framework-4.0.0/ruby/lib/ruby/site_ruby:/opt/framework-4.0.0/ruby/lib/ruby/site_ruby/1.9.1:/opt/framework-4.0.0/ruby/lib/ruby/site_ruby/1.9.1/i686-linux"
RUBYOPT=rubygems
export GEM_HOME
export RUBY_HOME
export RUBYLIB
export RUBYOPT
##### POSTGRES ENV #####

        
