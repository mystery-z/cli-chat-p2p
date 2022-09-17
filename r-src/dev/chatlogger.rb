ip = '123.456.789'
port = 4522

def chatlogger(ip,port)
	directory_name = "#{ip},#{port}"
	Dir.mkdir(directory_name) unless File.exists?(directory_name)
	File.new("temp.txt", "w")
	write
	
	
	
end

chatlogger(ip,port)
