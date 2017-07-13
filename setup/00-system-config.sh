#!/bin/sh

echo ">>>Installing Python2.7 pip + dependencies"
cd /home/pi
wget https://bootstrap.pypa.io/get-pip.py
sudo /usr/bin/python get-pip.py
sudo rm /home/pi/get-pip.py

echo ">>>Upgrading pip"
sudo pip install -U pip

echo ">>>Installing python development packages"
sudo apt-get install -y python-dev

echo ">>>Installing git"
sudo apt-get install -y git

echo ">>>Installing pySerial for serial communication"
sudo pip install pyserial
