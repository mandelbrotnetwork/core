#!/bin/bash
cp /proc/sys/kernel/random/uuid uuid

echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
apt-get update
apt-get upgrade -y

sudo apt-get install ansible python-minimal aptitude rng-tools -y

echo "HRNGDEVICE=/dev/hwrng" | sudo tee -a /etc/default/rng-tools

service rng-tools restart

usermod -l mantle dietpi
usermod -d /home/mantle -m mantle
groupmod -n mantle dietpi
mv /home/dietpi/ /home/mantle

echo 'mantle ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo

cd /home/mantle

cat >> setup.sh << EOF
#!/bin/bash

ansible-pull -U https://github.com/mandelbrotnetwork/mantle.git

EOF

systemctl unmask hostapd
systemctl enable hostapd
systemctl start hostapd

chmod +x setup.sh
chown mantle setup.sh
sudo -u mantle ./setup.sh