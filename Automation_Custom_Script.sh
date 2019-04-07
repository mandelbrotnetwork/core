#!/bin/bash

# install deps
apt-get install python

echo "install node"
npm install -g pm2

echo "clone ground"
git clone git@github.com:mandelbrotnetwork/mantle.git

pushd mantle

pm2 start ecosystem.config.js
pm2 startup
