#!/bin/sh

echo ">>>Installing bluetooth development packages"
sudo apt-get install -y libbluetooth-dev

echo ">>>Installing PyBluez"
sudo pip install -y pybluez

echo ">>>Setting the bluetooth daemon to run in compatibility mode"
if grep -q 'ExecStart=/usr/lib/bluetooth/bluetoothd -C' /lib/systemd/system/bluetooth.service; then
    echo "---compatibility mode already set"
else
    original_line="ExecStart=/usr/lib/bluetooth/bluetoothd"
    new_line="ExecStart=/usr/lib/bluetooth/bluetoothd -C"
    sudo sed -i "s%$original_line%$new_line%g" /lib/systemd/system/bluetooth.service
fi

echo ">>>Copying bluetooth-server service to systemd"
sudo cp /home/pi/tribes-pi-config/services/bluetooth-server.service /lib/systemd/system/bluetooth-server.service

echo ">>>Load serial port profile"
sudo sdptool add SP

echo ">>>Applying permissions for bluetooth-server service"
sudo chmod 644 /lib/systemd/system/bluetooth-server.service

echo ">>>Reloading the systemd daemon and bluetooth services"
sudo systemctl daemon-reload
sudo systemctl restart bluetooth