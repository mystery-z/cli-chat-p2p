require 'socket'
Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)[0][3]
