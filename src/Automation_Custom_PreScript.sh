#!/bin/bash

cp /proc/sys/kernel/random/uuid /root/uuid

PASS=$( cat uuid | cut -f1 -d'-' )

sed "s/AUTO_SETUP_NET_HOSTNAME=Mandelbrot/AUTO_SETUP_NET_HOSTNAME=Mandelbrot-$PASS/g" /DietPi/dietpi.txt > /DietPi/dietpi.txt
sed "s/AUTO_SETUP_GLOBAL_PASSWORD=.*/AUTO_SETUP_GLOBAL_PASSWORD=$PASS/g" /DietPi/dietpi.txt > /DietPi/dietpi.txt
sed "s/SOFTWARE_WIFI_HOTSPOT_KEY=.*/SOFTWARE_WIFI_HOTSPOT_KEY=$PASS/g" /DietPi/dietpi.txt > /DietPi/dietpi.txt
sed "s/SOFTWARE_WIFI_HOTSPOT_SSID=.*/SOFTWARE_WIFI_HOTSPOT_SSID=Mandelbrot-$PASS/g" /DietPi/dietpi.txt > /DietPi/dietpi.txt
