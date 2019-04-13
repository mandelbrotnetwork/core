#1/bin/bash

. /DietPi/dietpi/func/dietpi-globals
G_PROGRAM_NAME='Mandelbrot-Pi-Hole-AP'
G_INIT

wget http://install.pi-hole.net -O install.sh
chmod +x install.sh

mkdir /etc/pihole

cat > /etc/pihole/setupVars.conf << EOF
BLOCKING_ENABLED=true
PIHOLE_INTERFACE=wlan0
IPV4_ADDRESS=192.168.42.1/24
IPV6_ADDRESS=
PIHOLE_DNS_1=1.1.1.1
PIHOLE_DNS_2=1.0.0.1
QUERY_LOGGING=true
INSTALL_WEB_SERVER=true
INSTALL_WEB_INTERFACE=true
LIGHTTPD_ENABLED=true
WEBPASSWORD=0a935d8a09c4ff3e68e9012565b267510397eca2dd9447110b19d7bb61529789
EOF

./install.sh --disable-install-webserver --unattended

rm install.sh

pushd /var/www

[[ -L admin ]] || { [[ -e admin ]] && mv -v admin admin.bak; }
ln -vsf html/admin admin
[[ -L pihole ]] || { [[ -e pihole ]] && mv -v pihole pihole.bak; }
ln -vsf html/pihole pihole

G_CONFIG_INJECT 'BLOCKINGMODE=' 'BLOCKINGMODE=IP-NODATA-AAAA' /etc/pihole/pihole-FTL.conf
ln -vsf pihole/index.php index.php

G_CONFIG_INJECT '# Required-Stop:' '# Required-Stop: $network $remote_fs' /etc/init.d/pihole-FTL
G_CONFIG_INJECT '# Required-Start:' '# Required-Start: $network $remote_fs' /etc/init.d/pihole-FTL

systemctl enable pihole-FTL

# - Run Gravity
pihole -g

pihole -a -p $(sudo openssl enc -d -a -md sha256 -aes-256-cbc $pbkdf2 -salt -pass pass:'DietPiRocks!' -in /var/lib/dietpi/dietpi-software/.GLOBAL_PW.bin)

sed -i "s/domain-name-servers.*/domain-name-servers\ 192.168.42.1;/" /etc/dhcp/dhcpd.conf 
echo "addn-hosts=/etc/pihole/lan.list" | tee -a /etc/dnsmasq.d/02-lan.conf
echo '192.168.42.1 mandelbrot.local' | tee -a /etc/pihole/lan.list

sed -i 's/aSOFTWARE_INSTALL_STATE[93]=0/aSOFTWARE_INSTALL_STATE[93]=2/g' /DietPi/dietpi/.installed

# enable access point
systemctl unmask hostapd
systemctl enable hostapd

dietpi-software install 84

popd