local socket = require("socket")


local netowrkIP = socket.dns.toip(socket.dns.gethostname())
