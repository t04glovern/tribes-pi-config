from bluetooth import *

from time import sleep
from datetime import datetime
from uuid import getnode as get_mac
import json

server_sock = BluetoothSocket(RFCOMM)
server_sock.bind(("", PORT_ANY))
server_sock.listen(1)

port = server_sock.getsockname()[1]

uuid = "00001101-0000-1000-8000-00805F9B34FB"

advertise_service(server_sock, "NODE-001",
                  service_id=uuid,
                  service_classes=[uuid, SERIAL_PORT_CLASS],
                  profiles=[SERIAL_PORT_PROFILE],
                  # protocols = [ OBEX_UUID ]
                  )

print("Waiting for connection on RFCOMM channel %d" % port)

client_sock, client_info = server_sock.accept()
print("Accepted connection from ", client_info)

try:
    while True:
        data = client_sock.recv(1024)
        if len(data) == 0: break
        print("received [%s]" % data)

        if data == '1':
            data = {"sensor_id": "NODE-001", "sensor_mac": get_mac(), "location_lon": 115.8594,
                    "location_lat": -31.9719, "timestamp": datetime.utcnow().strftime("%Y%m%d")}
            json_data = json.dumps(data)
            client_sock.send(json_data)

except IOError:
    pass

print("disconnected")

client_sock.close()
server_sock.close()
print("all done")
