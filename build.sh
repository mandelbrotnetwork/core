#!/bin/bash

mkdir ./tmp
pushd ./tmp
echo "get dietpi archive"
wget https://dietpi.com/downloads/images/DietPi_RPi-ARMv6-Stretch.7z
echo "unzip dietpi archive"
7z x DietPi_RPi-ARMv6-Stretch.7z
echo "mount image"
hdiutil mount DietPi_v6.20_RPi-ARMv6-Stretch.img

cp -f ../dietpi.txt /Volumes/boot/dietpi.txt
cp -f ../Automation_Custom_Script.sh /Volumes/boot/Automation_Custom_Script.sh

hdiutil unmount /Volumes/boot

cp -f DietPi_v6.20_RPi-ARMv6-Stretch.img ../out.img

popd
rm -rf ./tmp