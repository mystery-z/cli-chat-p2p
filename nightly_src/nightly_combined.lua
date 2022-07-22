-- write teh combined code here

--~ server is meant to only send
--~ client is menat to listen and print all but nil

local socket = require("socket")

myport = math.random(7000, 7999)



local function server_send()
	local server = assert(socket.bind("192.168.1.11", myport)) 
	--~ change this part later to get ipv4 ip
		
	local myip, myport = server:getsockname()
	-- print a message informing what's up
	print("Please connect to localhost on port " .. myport .. " and [local] ip " .. myip)
	print("After connecting, you have 30seconds to connect")
	-- loop forever waiting for clients
	while 1 do
	  -- wait for a connection from any client
	  local client = server:accept()
	  -- make sure we don't block waiting for this client's line
	  client:settimeout(30)
	  if client == true then end
	  -- receive the line
	while 1 do   
	  io.write(">>")
	  local msg = io.read()
      client:send(msg.."\n") 
      --~ must add "\n" otherwise won't work 
	end
	--~ client:close() 

end
end

local function client_listen()
	tcp = assert(socket.tcp())
	--~ init tcp
	io.write("Port [to connect to]: ")
	port = io.read()
	io.write("IP address [to connect to]: ")
	ip = io.read()
	tcp:connect(ip, port);
	--note the newline below
	tcp:send("first msg\n");
--~ print("sent;")
--~ fix the next 7 lines to continue listening, not just to close connection when done
	while true do
		local msg, status, partial = tcp:receive()
		if msg ~= nil then
			print(msg or partial)
		else end
	end
--~ print("closin;")
	--~ tcp:close()
end

server_send()
client_listen()
--~ next steps:
--~ 1.get the above two functoins to work in concurrent mode
--~ 2. lines 13 and 14
