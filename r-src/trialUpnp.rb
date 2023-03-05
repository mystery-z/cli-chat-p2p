require 'socket'

#~ # Search for all devices (do an M-SEARCH with the ST header set to 'ssdp:all')
#~ all_devices = Playful::SSDP.search  
#~ puts all_devices

ssdp = SSDP.new
resources = ssdp.search
