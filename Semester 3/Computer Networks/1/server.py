import socket
import struct
import threading
import time

clients=[]
counting_clients=0


def worker(client):
    global clients,counting_clients
    print("Hello client #"+str(counting_clients)+"# , "+str(client.getpeername()))
    clients.append(client.getpeername())

    count_to_send=struct.pack("!I",counting_clients)

    client.send(count_to_send)

    data_to_send=bytes(str(client.getpeername()),'ascii')
    client.send(data_to_send)
    time.sleep(1)
    client.close()


HOST='localhost'
PORT=1234


if __name__=='__main__':

    try:
        s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
        s.bind((HOST,PORT))
    except socket.error as msg:
        print("Error: ", msg.strerror)
        exit(-1)
    s.listen(1)
    print("Waiting for a client...")

    while True:
        client_s,addr=s.accept()
        counting_clients+=1
        t=threading.Thread(target=worker, args=(client_s,))
        t.start()
        t.join()