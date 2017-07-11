#!/bin/sh

# Set bluetooth name

# Install the bluetooth development packages
sudo apt-get install libbluetooth-dev

# Install pybluez
sudo pip install pybluez

# Reload the systemd daemon and restart bluetooth service
sudo systemctl daemon-reload
sudo systemctl restart bluetooth

# Configure the bluetooth serial interface
sudo hciconfig hci0 up
sudo hciconfig hci0 sspmode 1
sudo hciconfig hci0 piscan
