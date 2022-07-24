local socket = require("socket")

local function open_server() -- create a TCP socket and bind it to the local host, at any port
	local server = assert(socket.bind("*", 3009))

	-- find out which port the OS chose for us
	local ip, port = server:getsockname()
	-- print a message informing what's up
	print("Please connect to localhost on port " .. port .. " and [local] ip " .. ip)
	print("After connecting, you have 10s to enter a line to be echoed")
	-- loop forever waiting for clients
	while 1 do
	  -- wait for a connection from any client
	  local client = server:accept()
	  -- make sure we don't block waiting for this client's line
	  client:settimeout(10)
	  -- receive the line
	  local line, err = client:receive()
	  print(line)
	  print(">>")
	  local msg = io.read()
      client:send(msg.."\n") 
      --~ must add "\n" otherwise won't work
	  client:close()
	  
	end
end

open_server()


--~ name = socket.dns.gethostname()
--~ name = socket.dns.toip(name)
--~ print(name)
