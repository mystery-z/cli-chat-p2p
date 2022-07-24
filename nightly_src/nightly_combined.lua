-- write teh combined code here

--~ server is meant to only send
--~ client is menat to listen and print all but nil

local socket = require("socket")
local lanes = require("lanes")

myport = math.random(7000, 7999)
localIP = socket.dns.toip(socket.dns.gethostname())



local function server_send()
   -- Starts send server 
   local server = assert(socket.bind(localIP, myport))

   local myip, myport = server:getsockname()

   -- FIX THIS SO THAT YOU DONT NEED TO SHOW THIS TO THE OTHER PERSON
      -- COULD POSSIBLY HAVE THE OTHER USER SEARCH ALL 1000 PORTS FOR A SPECFIC PACKET
      -- try using udp for the start so that it can connnect
   -- print a message informing what's up
   print("Please connect to localhost on port " .. myport .. " and [local] ip " .. myip)
   print("After connecting, you have 30 seconds to connect")
   -- loop forever waiting for clients
   while 1 do
      -- wait for a connection from any client
      local client = server:accept()
      -- make sure we don't block waiting for this client's line
      client:settimeout(30)
      -- receive the line
      while true do
         io.write(">>")
         local msg = io.read()
         client:send(msg.."\n")
         --~ must add "\n" otherwise won't work 
      end
      --~ client:close() 

   end --~and no this is not an error, there's meant to be 2 ends
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
   tcp:send("Connected\n");
   --~ print("sent;")
   while true do
      local msg, status, partial = tcp:receive()
      if msg ~= nil then
         print(msg or partial)
      else end
   end
   --~ print("closin;")
   -- tcp:close()
end

server_send()
client_listen()




--~ next steps:
--~ 1.get the above two functoins to work in concurrent mode
--~ 2. lines 13 and 14
