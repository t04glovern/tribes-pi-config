from time import sleep
import serial

# Establish the connection on a specific port
ser = serial.Serial(port='/dev/ttyGS0', baudrate=115200, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE, bytesize=serial.EIGHTBITS, timeout=1)

while True:
	x = ser.readline()
	print x
