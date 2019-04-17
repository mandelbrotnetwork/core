#!/bin/bash

cp /proc/sys/kernel/random/uuid uuid

PASS=$( cat uuid | cut -f1 -d'-' )

sed "s/AUTO_SETUP_NET_HOSTNAME=Mandelbrot/AUTO_SETUP_NET_HOSTNAME=Mandelbrot-$PASS/g" dietpi.txt
sed "s/AUTO_SETUP_GLOBAL_PASSWORD=.*/AUTO_SETUP_GLOBAL_PASSWORD=$PASS/g" dietpi.txt

