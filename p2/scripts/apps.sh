#/bin/sh

kubectl apply -f /vagrant/confs

kubectl wait deploy --all --for condition=Available -n kube-system --timeout=-1s
kubectl wait deploy --all --for condition=Available -n default --timeout=-1s
