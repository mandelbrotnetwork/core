#!/bin/bash

usermod -l benoit dietpi
usermod -d /home/benoit -m benoit
groupmod -n benoit dietpi
mv /home/dietpi/ /home/benoit

cp /boot/Benoit_Setup.sh /home/benoit/setup.sh

sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo systemctl start hostapd

cd /home/benoit
chown benoit setup.sh
sudo -u benoit ./setup.sh