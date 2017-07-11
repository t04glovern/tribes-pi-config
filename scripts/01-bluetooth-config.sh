#!/bin/sh

# Set bluetooth name

# Install the bluetooth development packages
sudo apt-get install libbluetooth-dev

# Install pybluez
sudo pip install pybluez

# Run the bluetooth daemon in compatibility mode (add '-C' after bluetoothd)
sudo nano /lib/systemd/system/bluetooth.service

# Reload the systemd daemon and restart bluetooth service
sudo systemctl daemon-reload
sudo systemctl restart bluetooth

# Load serial port profile
sudo sdptool add SP

# Configure the bluetooth serial interface
sudo hciconfig hci0 up
sudo hciconfig hci0 piscan
sudo hciconfig hci0 name 'NODE-001'
