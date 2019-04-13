#!/bin/bash


# install and configure PI hole to work with AP
/boot/Pi_Hole_AP.sh

usermod -l benoit dietpi
usermod -d /home/benoit -m benoit
groupmod -n benoit dietpi
mv /home/dietpi/ /home/benoit

cp /boot/Benoit_Setup.sh /home/benoit/setup.sh

cd /home/benoit
chown benoit setup.sh
sudo -u benoit ./setup.sh