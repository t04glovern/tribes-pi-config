#!/bin/bash

# Change hostname if needed
current_hostname="$(cat /etc/hostname)"
rasp='raspberrypi'

echo '>>>Hostname must be changed for node network'
if [ "$current_hostname" == "$rasp" ]; then
    echo 'Enter Node name, followed by [ENTER]:'
    read node_name
    while true; do
        read -p "To confirm, node_name is ${node_name}? [y/n]" yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) echo 'Please re-run the script with the correct input'; exit;;
            * ) echo 'Please answer y/n.';;
        esac
    done

    echo ">>>Changing hostname to ${node_name}"
    sudo sed -i "s%$current_hostname%$node_name%g" /etc/hostname
    sudo sed -i 's%$current_hostname%$node_name%g' /etc/hosts

    echo ">>>Committing name to ${node_name} system"
    sudo /etc/init.d/hostname.sh

    echo ">>>Rebooting system to apply hostname"
    sudo reboot
fi
