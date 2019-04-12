#!/bin/bash
rm -rf dist
mkdir ./tmp
mkdir ./dist
pushd ./tmp
echo "get dietpi archive"
wget https://dietpi.com/downloads/images/DietPi_RPi-ARMv6-Stretch.7z
echo "unzip dietpi archive"
7z x DietPi_RPi-ARMv6-Stretch.7z
echo "mount image"
hdiutil mount DietPi_RPi-ARMv6-Stretch.img

cp -f ../src/dietpi.txt /Volumes/boot/dietpi.txt
cp -f ../src/Automation_Custom_Script.sh /Volumes/boot/Automation_Custom_Script.sh
cp -f ../src/Benoit_Setup.sh /Volumes/boot/Benoit_Setup.sh

hdiutil unmount /Volumes/boot

cp -f DietPi_RPi-ARMv6-Stretch.img ../dist/mandelbrot.img

popd
rm -rf ./tmp