require 'socket' 

def listener()
  #import port and hostname
  hostname = '192.168.1.11' 
  port = 1880
  open_Socket = TCPSocket.open(hostname, port)

  loop do
    # receive msg from socket
    msg = open_Socket.gets     
    if msg != nil
      msg = msg.chop()
      # print the msg
      puts(msg)  
    else 
      next
    end
  end
end
#~ works

def sender()
  server = TCPServer.new('192.168.1.11', 1880)
   # somehow works with global ip but requires port forwarding
  loop do 
    client = server.accept
    loop do         
    # Servers run forever       
      print(">>") 
      msg = gets
      client.print(msg)         
    end
  end
end
#~ works

#~ sender()
listener()
