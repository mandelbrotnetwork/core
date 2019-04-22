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

cp -f -R ../src/ /Volumes/boot/

OWNER=$( git config --get remote.origin.url | cut -f2 -d':' | cut -f1 -d'/' )
BRANCH=$( git branch | grep \* | cut -d ' ' -f2 )

sed -ie "s/__BRANCH__/$BRANCH/g" /Volumes/boot/Automation_Custom_Script.sh
sed -ie "s/__OWNER__/$OWNER/g" /Volumes/boot/Automation_Custom_Script.sh

hdiutil unmount /Volumes/boot

cp -f DietPi_RPi-ARMv6-Stretch.img ../dist/mandelbrot.img

popd
rm -rf ./tmp