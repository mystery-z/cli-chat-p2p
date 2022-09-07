require 'socket'
myip = ((Socket.ip_address_list.detect{|intf| intf.ipv4_private?}).ip_address).delete_suffix("%")
puts (myip)
