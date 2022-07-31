require 'socket'                 # Get sockets 

server = TCPServer.new('192.168.1.11', 1880)    # somehow works with global ip but requires port forwarding
loop do 
  client = server.accept
  loop do                # Servers run forever
    print(">>")
    msg = gets
    client.print(msg)         
  end
end

# works 
