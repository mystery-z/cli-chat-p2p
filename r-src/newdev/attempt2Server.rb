require 'socket'

server = TCPServer.new 2003 # Server bound to port 2000

#~ while response = client.gets
  #~ client = server.accept    # Wait for a client to connect
  #~ client.puts "Hello !"
  #~ client.puts "Time is #{Time.now}"
  
  #~ print(response)

  #~ client.close
#~ end
loop{
  client = server.accept
  client.puts "hi"
  while line = client.gets
    puts line.chomp
    break if line == "aaa"
  end
  print "end"
  # rest of loop ...
}
