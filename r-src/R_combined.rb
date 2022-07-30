require 'socket' 
require 'thread'

ip = '192.168.1.11'
port = 1880

#~ delete here latr
myip = '192.168.1.11'
myport = 1880

def listener(myip, myport)
  #import port and hostname
  open_Socket = TCPSocket.open(ip, port)

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

def sender(myip, myport)
  server = TCPServer.new(myip, myport)
   # somehow works with global ip but requires port forwarding
  loop do 
    client = server.accept
    loop do         
    # Servers run forever       
      print(">>") 
      msg = gets
      json_packer(myip, myport, msg)     
      #~ make the packed json the sent thing, not msg
      client.print(msg)       
    end
  end
end
#~ works

def json_packer(myip, myport, msg)
  time = Time.new
  time = time.inspect
  json_data = "{'ip': '#{myip}', 'port': #{myport}, 'msg': '#{msg}', 'time':'#{time}'}"
  file = File.new("send.json", "w")
  file.syswrite(json_data)
  file.close()
end


#~ listener(ip, port)
sender(ip,port)


