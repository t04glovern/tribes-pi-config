# tribes-pi-config
Configuration instructions for the Pi Zero W for Digital Tribes

## USB On The Go setup

After burning your rasbian lite image run the following command to view the mounted partitions on your system

```bash
df -h

Filesystem      Size   Used  Avail Capacity iused      ifree %iused  Mounted on
/dev/disk1     346Gi  335Gi   10Gi    98% 3732570 4291234709    0%   /
devfs          335Ki  335Ki    0Bi   100%    1160          0  100%   /dev
/dev/disk0s4   119Gi   75Gi   44Gi    64%  488100   45768008    1%   /Volumes/BOOTCAMP
map -hosts       0Bi    0Bi    0Bi   100%       0          0  100%   /net
map auto_home    0Bi    0Bi    0Bi   100%       0          0  100%   /home
/dev/disk2s1    41Mi   21Mi   20Mi    51%       0          0  100%   /Volumes/boot
```

Notice that the last image */Volumes/boot* is the location of our rasbian image on the MicroSD

Navigate into the *boot* folder on the drive and edit the *config.txt* file

```bash
sudo nano /Volumes/boot/config.txt
```
At the bottom of this file add the following line to make sure we are using the dwc2 USB driver 

```bash
dtoverlay=dwc2
```

## Enable SSH

Create an empty file called *ssh* in */boot*

```bash
sudo touch /Volumes/boot/ssh
```
