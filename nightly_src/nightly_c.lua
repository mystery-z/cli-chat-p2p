local host, port = "0.0.0.0", 3002
local socket = require("socket")
local tcp = assert(socket.tcp())

tcp:connect(host, port);
--note the newline below
tcp:send("first msg\n");
--~ fix the next 7 lines to continue listening, not just to close connection when done
while true do
    local s, status, partial = tcp:receive()
    print(s or partial)
    if status == "closed" then break end
end
tcp:close()
