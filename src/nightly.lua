local socket = require("socket")

local server = assert(socket.bind("*", 0))

local ip, port = server:getsockname()

while 1 do
  -- wait for a connection from any client
	server:settimeout(2)
	local client, err = server:accept()
	print(client, err)
	local client = server:accept()
  -- make sure we don't block waiting for this client's line
	client:settimeout(10)
  -- receive the line
	local line, err = client:receive()
  -- if there was no error, send it back to the client
	if not err then client:send(line .. "\n") end
  -- done with client, close the object
	client:close()
end
