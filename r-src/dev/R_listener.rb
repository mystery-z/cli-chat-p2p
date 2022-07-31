require 'socket'                 # Get sockets 

hostname = '192.168.1.11' #import port and hostname
port = 1880
open_Socket = TCPSocket.open(hostname, port)

loop do
  msg = open_Socket.gets     # receive msg from socket
  if msg != nil
    msg = msg.chop()
    puts(msg)  # print the msg
  else 
    next
  end
end

#~ works
