host, port = "0.0.0.0", 3009
socket = require("socket")
tcp = assert(socket.tcp())

tcp:connect(host, port);
--note the newline below
tcp:send("first msg\n");
print("sent;")
--~ fix the next 7 lines to continue listening, not just to close connection when done
while true do
    local msg, status, partial = tcp:receive()
    if msg ~= nil then
		print(msg or partial)
	else end
end
print("closin;")
tcp:close()

