require 'socket' 
require 'thread'
require 'json'
require 'logger'


# [TODO] delete these later
ip = '10.180.1.161'
port = 5009

myip = '10.180.10.108'
myport = 5009

def listener(ip, port) #~ this is the ip and port that this will listen from
  #~ open for an ip and port
  loop do
    #~ receive msg from socket
    msg = $open_Socket.gets     
    if msg != nil
      #~ unpack the json file
      json_unpacker(msg)
      #~ print the msg
      print($parsed_msg)  
    else 
      next
    end
  end
end

def sender(myip, myport) #~ this is the ip and port taht is being opened on this computer
  server = TCPServer.new(myip, myport)
  #~ somehow works with global ip but requires port forwarding
  loop do 
    client = server.accept
    loop do         
    #~ Server runs forever       
      msg = gets
      msg = msg.chop()
      json_packer(myip, myport, msg)     
      #~ json_packer puts the msg inside the formatted json, MUST use file.READ not file.OPEN
      json_msg = File.read("send.json")
      client.print(json_msg)       
      print(">>")
      #~ get the correctly formatted packet and send it (previous TWO lines)
    end
  end
end

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
  $parsed_msg = "[#{data['ip']}:#{data['port']}]: "+data['msg'] + "\n>>"
end

def init_connection(ip,port,myip,myport) #~ initialisation of the connection
  t1 = Thread.new{trial_connect_listen(ip,port)} #~ multithreading trial_connect_listen and sender
  t2 = Thread.new{sender(myip,myport)}
  t1.join
  t2.join
end

def trial_connect_listen(ip,port) 
  begin #~ inf. loop of trying to listen from ip, port
    $open_Socket = TCPSocket.open(ip, port)
  rescue
	retry
  end
  print(">>")
  listener(ip,port) #~ when the trial is done just switch to listener
end

def chatLogger()
 # [TODO] do the chatLogger thing
end

init_connection(ip,port,myip,myport)
