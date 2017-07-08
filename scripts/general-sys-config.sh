#!/bin/sh

# Install Python2.7 pip + dependencies
sudo apt-get install python-pip

# Install pySerial for serial communication
sudo pip install pyserial

# Make scripts directory
mkdir /home/pi/scripts
