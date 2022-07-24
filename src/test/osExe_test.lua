
local socket = require("socket")
a = socket.dns.gethostname()
y = socket.dns.toip(socket.dns.gethostname())
print(tostring(y))
