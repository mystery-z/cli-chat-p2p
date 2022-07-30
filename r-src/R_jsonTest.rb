require 'json'

ip = '123.456.789.223'
port = 2202
msg = "hah"

json_data = "{'ip': '#{ip}', 'port': #{port}, 'msg': '#{msg}'}"


puts json_data
 
file = File.new("test.json", "w")
file.syswrite(json_data)

file.close()

