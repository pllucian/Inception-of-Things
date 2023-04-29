#/bin/sh

apt-get update
apt-get -y install curl net-tools

curl -sfL https://get.k3s.io | \
	sh -s - server --node-ip 192.168.56.110 --token secret --write-kubeconfig-mode 644
