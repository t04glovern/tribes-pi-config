#!/bin/sh

# Install Python2.7 pip + dependencies
sudo apt-get install python-pip

# Install the python development packages
sudo apt-get install python-dev

# Install the bluetooth development packages
sudo apt-get install libbluetooth-dev

# Install pySerial for serial communication
sudo pip install pyserial

# Install the PyBluez bluetooth wrappers
pip install pybluez

# Make scripts directory
mkdir /home/pi/scripts
