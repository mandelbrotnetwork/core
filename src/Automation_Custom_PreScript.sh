#!/bin/bash

cp /proc/sys/kernel/random/uuid /root/uuid

PASS=$( cat /root/uuid | cut -f1 -d'-' )

sed -ie "s/AUTO_SETUP_NET_HOSTNAME=.*/AUTO_SETUP_NET_HOSTNAME=Mandelbrot-$PASS/g" /DietPi/dietpi.txt
sed -ie "s/AUTO_SETUP_GLOBAL_PASSWORD=.*/AUTO_SETUP_GLOBAL_PASSWORD=$PASS/g" /DietPi/dietpi.txt
sed -ie "s/SOFTWARE_WIFI_HOTSPOT_KEY=.*/SOFTWARE_WIFI_HOTSPOT_KEY=$PASS/g" /DietPi/dietpi.txt
sed -ie "s/SOFTWARE_WIFI_HOTSPOT_SSID=.*/SOFTWARE_WIFI_HOTSPOT_SSID=Mandelbrot-$PASS/g" /DietPi/dietpi.txt
