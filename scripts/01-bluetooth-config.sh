#!/bin/sh

# Install the bluetooth development packages
sudo apt-get install libbluetooth-dev

# Install the bluetooth low engery rependencies
sudo apt-get install pkg-config libboost-python-dev libboost-thread-dev libglib2.0-dev

# Install the PyBluez bluetooth low energy wrappers
sudo pip install pybluez[ble]

# Append --compat to the ExecStart line (someone write the sed for this)
#sudo nano /lib/systemd/system/bluetooth.service

# Reload the systemd daemon and restart bluetooth service
sudo systemctl daemon-reload
sudo systemctl restart bluetooth

# Configure the bluetooth serial interface
sudo hciconfig hci0 piscan
sudo hciconfig hci0 name 'NODE-001'
sudo hciconfig hci0 up
