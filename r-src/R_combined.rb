require 'socket' 
require 'thread'
require 'json'

# [TODO] delete these later
ip = '192.168.1.11'
port = 1880

myip = '192.168.1.11'
myport = 1880

def listener(ip, port)
  #~ open for an ip and port
  open_Socket = TCPSocket.open(ip, port)
  loop do
    #~ receive msg from socket
    msg = open_Socket.gets     
    if msg != nil
      #~ unpack the json file
      json_unpacker(msg)
      #~ print the msg
      puts($parsed_msg)  
    else 
      next
    end
  end
end
#~ works

def sender(myip, myport)
  server = TCPServer.new(myip, myport)
  #~ somehow works with global ip but requires port forwarding
  loop do 
    client = server.accept
    loop do         
    #~ Server runs forever       
      print(">>") 
      msg = gets
      msg = msg.chop()
      json_packer(myip, myport, msg)     
      #~ json_packer puts the msg inside the formatted json, MUST use file.READ not file.OPEN
      json_msg = File.read("send.json")
      client.print(json_msg)       
      #~ get the correctly formatted packet and send it (previous TWO lines)
    end
  end
end
#~ works

def json_packer(myip, myport, msg)
  #~ get the time
  time = Time.new
  time = time.inspect
  #~ set the structure for the json file 
  json_data = {
    "ip" => "#{myip}", 
    "port" => "#{myport}", 
    "time" => "#{time}", 
    "msg"=> "#{msg}" 
  } 
  # [IMPORTANT, TODO] change myport back to an integer (from string) later
  #~ write the actual .json file
  file = File.new("send.json", "w")
  file.syswrite(json_data.to_json+"\n")
  #~ the close is required because of the File.new operator
  file.close
end

def json_unpacker(msg)
  #~ open a new file and dump the packet in
  file = File.new("received.json","w")
  file.syswrite(msg)
  file.close
  #~ reopen the json file and parse it (im pretty sure there's a more efficient way but can't think of it)
  file1 = File.open("received.json")
  #~ load the json file
  data = JSON.load(file1)
  #~ save the actual parsed msg as a global var
  $parsed_msg = data['msg']
end

listener(myip, port)
#~ sender(ip,port)


