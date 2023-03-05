require 'socket' 
require 'thread'
require 'json'
require 'logger'


# [TODO delete these later
ip = '192.168.1.6'
port = 9016

myip = ((Socket.ip_address_list.detect{|intf| intf.ipv4_private?}).ip_address).delete_suffix("%") #~ totally not the easiest way to get device local IP 
myport = 9015

def init_setup()
	directory_name = "chatLogs"
	Dir.mkdir(directory_name) unless File.exists?(directory_name)
end


def listener(ip, port) #~ this is the ip and port that this will listen from
  #~ open for an ip and port
  loop do
    #~ receive msg from socket
    msg = $open_Socket.gets     
    if msg != nil
      #~ unpack the json file
      json_unpacker(msg, ip, port)
      chatLogger(ip,port,msg)
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
       chatLogger(myip,myport,json_msg)   
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
  # [IMPORTANT, TODO change myport back to an integer (from string) later
  #~ write the actual .json file
  file = File.new("send.json", "w")
  file.syswrite(json_data.to_json+"\n")
  #~ the close is required because of the File.new operator
  file.close
end

def json_unpacker(msg, ip, port)
  #~ open a new file and dump the packet in
  #~ Dir.chdir("chatLogs") #~ cd into chatLogs folder
  
  #~ directory_name = "#{ip},#{port}"
  #~ Dir.mkdir(directory_name) unless File.exists?(directory_name)
  
  #~ if File.exists?("temp.txt") == False
    #~ File.new("#{ip}: #{port}.log", "w") #~ check if log file exists already 
  #~ end
  #~ logFile = File.open("#{ip}: #{port}.log", "a") #~ open the log file
  #~ logFile.syswrite(msg) #~ write to the log file
  
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

def trial_connect_listen(ip,port) 
  begin #~ inf. loop of trying to listen from ip, port
    $open_Socket = TCPSocket.open(ip, port)
  rescue
	retry
  end
  print(">>")
  listener(ip,port) #~ when the trial is done just switch to listener
end

def init_connection(ip,port,myip,myport) #~ initialisation of the connection
  t1 = Thread.new{trial_connect_listen(ip,port)} #~ multithreading trial_connect_listen and sender
  t2 = Thread.new{sender(myip,myport)}
  t1.join
  t2.join
end

def chatLogger(ip,port,msg)
	if File.exist?("#{ip}.json") == true
		logger_File = File.new("#{ip}.json")
		logger_File = File.open("#{ip}.json", "a")
		logger_File.write(msg)
		logger_File.close()
	else
		logger_File = File.open("#{ip}.json", "a")
		logger_File.write(msg)
		logger_File.close()
	end
end

init_setup()

init_connection(ip,port,myip,myport)
