#!/bin/sh

# Install Python2.7 pip + dependencies
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py --user

# Upgrade pip
sudo pip install -U pip

# Install the python development packages
sudo apt-get install python-dev
