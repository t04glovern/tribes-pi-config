from time import sleep
from datetime import datetime
from uuid import getnode as get_mac
import json
import serial

# Establish the connection on a specific port
ser = serial.Serial(port='/dev/ttyGS0', baudrate=115200, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE,
                    bytesize=serial.EIGHTBITS, timeout=1)

while True:
    data = {"sensor_id": "NODE-001", "sensor_mac": get_mac(), "location_lon": 115.8594, "location_lat": -31.9719,
            "timestamp": datetime.utcnow().strftime("%Y%m%d")}
    json_data = json.dumps(data)
    ser.write(json_data)
    sleep(5)
