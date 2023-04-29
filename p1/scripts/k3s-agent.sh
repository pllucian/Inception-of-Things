#/bin/sh

apt-get update
apt-get -y install curl net-tools

curl -sfL https://get.k3s.io | \
	sh -s - agent --node-ip 192.168.56.111 --server https://192.168.56.110:6443 --token secret
