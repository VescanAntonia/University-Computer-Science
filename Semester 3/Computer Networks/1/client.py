import socket
import struct


# connect the client to the server
try:
    server=socket.create_connection(('localhost',1234))
except socket.error as msg:
    print("Error: ",msg.strerror)
    exit(-1)

# get and print the data so that the clients find out which client connected

nr_of_client=server.recv(4)
nr=struct.unpack("!I",nr_of_client)[0]

peer_to_get=server.recv(1024)
client_peer=peer_to_get.decode('ascii')
# print(nr)
print("Client with number "+str(nr)+" from "+client_peer+" connected.")

# create the UDP through which the clients communicate
# for the 'server'
HOST='localhost'
PORT=1234

udp_sock=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
udp_sock.bind(client_peer)
udp_client,addr=udp_sock.recvfrom(10)
print(udp_client)
udp_sock.sendto("hello",addr)
udp_sock.close()

# for the 'client' udp

udp_s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
udp_s.sendto("hello",(HOST,PORT))
udp_data=udp_s.recvfrom(10)
udp_s.close()

server.close()
