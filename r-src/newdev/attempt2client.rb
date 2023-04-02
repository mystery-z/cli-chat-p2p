require 'socket'

s = TCPSocket.new 'localhost', 2003

while line = s.gets # Read lines from socket
  puts line         # and print them
  s.print "hi"
end

s.close             # close socket when done
