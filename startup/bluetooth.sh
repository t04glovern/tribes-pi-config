#!/bin/sh

# Set bluetooth name
bluetooth_name="$(cat /etc/hostname)"

echo ">>>Bring bluetooth serial interface online"
sudo hciconfig hci0 up
sudo hciconfig hci0 piscan
sudo hciconfig hci0 name ${bluetooth_name}