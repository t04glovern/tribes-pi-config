#!/bin/sh

# Configure the bluetooth serial interface
sudo hciconfig hci0 name 'NODE-001'
sudo hciconfig hci0 up
sudo hciconfig hci0 sspmode 1
sudo hciconfig hci0 piscan
sudo bluetooth-agent 1234
