local host, port = "0.0.0.0", 80
local socket = require("socket")
local tcp = assert(socket.tcp())

tcp:connect(host, port);
--note the newline below
tcp:send("hello world\n");

while true do
    local s, status, partial = tcp:receive()
    print(s or partial)
    if status == "closed" then break end
end
tcp:close()
