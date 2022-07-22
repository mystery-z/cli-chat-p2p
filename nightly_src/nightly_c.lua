socket = require("socket")

--~ fallback version 1:

--~ host, port = "192.168.1.11", 7104
--~ tcp = assert(socket.tcp())

--~ tcp:connect(host, port);
--~ --note the newline below
--~ tcp:send("first msg\n");
--~ print("sent;")
--~ fix the next 7 lines to continue listening, not just to close connection when done
--~ while true do
    --~ local msg, status, partial = tcp:receive()
    --~ if msg ~= nil then
		--~ print(msg or partial)
	--~ else end
--~ end
--~ print("closin;")
--~ tcp:close()


--~ fallback verson 2:


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
	while true do
		local msg, status, partial = tcp:receive()
		if msg ~= nil then
			print(msg or partial)
		else end
	end
--~ print("closin;")
	--~ tcp:close()
end
	
client_listen()

	
