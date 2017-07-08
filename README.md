# tribes-pi-config
Configuration instructions for the Pi Zero W for Digital Tribes

## Headless Configuration

### USB dwc2 USB driver prep

After burning your rasbian lite image run the following command to view the mounted partitions on your system

```bash
$ df -h

Filesystem      Size   Used  Avail Capacity iused      ifree %iused  Mounted on
/dev/disk1     346Gi  335Gi   10Gi    98% 3732570 4291234709    0%   /
devfs          335Ki  335Ki    0Bi   100%    1160          0  100%   /dev
/dev/disk0s4   119Gi   75Gi   44Gi    64%  488100   45768008    1%   /Volumes/BOOTCAMP
map -hosts       0Bi    0Bi    0Bi   100%       0          0  100%   /net
map auto_home    0Bi    0Bi    0Bi   100%       0          0  100%   /home
/dev/disk2s1    41Mi   21Mi   20Mi    51%       0          0  100%   /Volumes/boot
```

Notice that the last image **/Volumes/boot** is the location of our rasbian image on the MicroSD

Navigate into the **boot** folder on the drive and edit the **config.txt** file

```bash
$ sudo nano /Volumes/boot/config.txt
```
At the bottom of this file add the following line to make sure we are using the dwc2 USB driver 

```bash
dtoverlay=dwc2
```

**OPTIONAL**: If you can't connect to the device over WiFi, add the following after **rootwait** in the **/boot/cmdline.txt** file. You'll be removing these later on in the tutorial.

```bash
modules-load=dwc2,g_ether
```

Your **cmdline.txt** will look something like this after the optional step

```bash
dwc_otg.lpm_enable=0 console=serial0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait modules-load=dwc2,g_ether
```

### Enable SSH

Create an empty file called **ssh** in **/boot**

```bash
$ sudo touch /Volumes/boot/ssh
```

### Setup Headless WiFi connection

Create another file in **/boot** called **wpa_supplicant.conf** and add your WiFi configuration

```bash
network={
  ssid="SSID"
  psk="password"
  key_mgmt=WPA-PSK
}
```

## Booting and Configuring System

### Connecting over SSH

Connect your Pi to the powersource and give it a minute to boot. Once it's booted you should be able to connect to your pi over **raspberrypi.local** if you have the Bonjour service setup on your system. Otherwise find the IP address of the Pi through your router/AP's connected device list

SSH in using the following command

```bash
$ ssh pi@raspberrypi.local
```

The user details by default are:

```yaml
user: pi
pass: raspberry
```

### Change the default password

Change the default **pi** user password by typing the following:

```bash
$ passwd

Changing password for pi.
(current) UNIX password: raspberry
Enter new UNIX password: <nice-try>
Retype new UNIX password: <nice-try>
passwd: password updated successfully
```

### Enable the dwc2 USB driver in rasbian

```bash
$ echo "dwc2" | sudo tee -a /etc/modules
```

You can open the **/etc/modules** file to confirm **dwc2** is now listed there

```bash
$ sudo nano /etc/modules

# /etc/modules: kernel modules to load at boot time.
#
# This file contains the names of kernel modules that should be loaded
# at boot time, one per line. Lines beginning with "#" are ignored.

dwc2
```

## Setting up system for gadgets

### Create USB Gadget script

Create a file in **/boot** called **create-usb-gadgets**

```bash
$ sudo nano /boot/create-usb-gadgets
```

Add the following contents to the file

**NOTE**: *The Linux USB website has a full list of Vendor IDs and Device IDs: http://www.linux-usb.org/usb.ids*

```bash
#!/bin/sh

# Load libcomposite
modprobe libcomposite

# Create a gadget called usb-gadgets
cd /sys/kernel/config/usb_gadget/
mkdir -p usb-gadgets
cd usb-gadgets

# Configure our gadget details
echo 0x1d6b > idVendor # Linux Foundation
echo 0x0104 > idProduct # Multifunction Composite Gadget
echo 0x0100 > bcdDevice # v1.0.0
echo 0x0200 > bcdUSB # USB2
mkdir -p strings/0x409
echo "fedcba9876543210" > strings/0x409/serialnumber
echo "Pi Zero W USB Gadget" > strings/0x409/manufacturer
echo "Pi Zero W USB Gadget" > strings/0x409/product
mkdir -p configs/c.1/strings/0x409
echo "Config 1: ECM network" > configs/c.1/strings/0x409/configuration
echo 250 > configs/c.1/MaxPower

# Add functions here



# End functions
ls /sys/class/udc > UDC
```

Make this script executable so that we can run it:

```bash
$ sudo chmod +x /boot/create-usb-gadgets
```

### Run USB Gadget script on boot

Create a new systemd service by running the following command

```bash
$ sudo nano /etc/systemd/system/create-usb-gadgets.service
```

Populate this file with the following

```bash
[Unit]
Description=Create USB gadgets

[Service]
Type=oneshot
ExecStart=/boot/create-usb-gadgets
StandardInput=tty
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

Finally enable the service

```bash
$ sudo systemctl daemon-reload
$ sudo systemctl enable create-usb-gadgets
```

### Clean up existing modules_load

If you used a guide that had you add **modules-load=dwc2,g_ether** to **/boot/cmdline.txt** you can remove these from the file now

```bash
$ sudo nano /boot/cmdline.txt
```

Reboot the Pi and you have the basic setup for loading gadgets now

## Optional Gadgets

When adding new gadgets you place them in the **/boot/create-usb-gadgets** file between the **Add functions here** and **# End functions** comments.
