#!/bin/sh

# Install the bluetooth development packages
sudo apt-get install libbluetooth-dev

# Install pySerial for serial communication
sudo pip install pyserial

# Install the PyBluez bluetooth wrappers
pip install pybluez

# Append --compat to the ExecStart line (someone write the sed for this)
#sudo nano /lib/systemd/system/bluetooth.service

# Reload the systemd daemon and restart bluetooth service
sudo systemctl daemon-reload
sudo systemctl restart bluetooth

# Configure the bluetooth serial interface
sudo hciconfig hci0 piscan
sudo hciconfig hci0 name 'NODE-001'
sudo hciconfig hci0 up
