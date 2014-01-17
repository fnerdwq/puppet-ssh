# taken from saz/ssh and modified (FW)
module Puppet::Parser::Functions
    newfunction(:ipaddresses, :type => :rvalue, :doc => <<-EOS
Returns all ip addresses of network interfaces (except lo) found by facter.
EOS
    ) do |args|
        interfaces = lookupvar('interfaces')

        return false if (interfaces == :undefined)

        result = []

        interfaces = interfaces.split(',')
        interfaces.each do |iface|
            if ! iface.include?('lo')
                ipaddr = lookupvar("ipaddress_#{iface}")
                ipaddr6 = lookupvar("ipaddress6_#{iface}")
                if ipaddr
                    result << ipaddr
                end
                if ipaddr6
                    result << ipaddr6
                end
            end
        end

        return result
    end
end
