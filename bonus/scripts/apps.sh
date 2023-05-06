#!/bin/sh

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd --type=merge --patch-file /vagrant/confs/argocd-patch.yml

kubectl create namespace dev
kubectl apply -f /vagrant/confs/playground.yml

kubectl create namespace gitlab
kubectl apply -f /vagrant/confs/gitlab.yml

curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

kubectl wait deploy --all --for condition=Available -n kube-system --timeout=-1s
kubectl wait deploy --all --for condition=Available -n argocd --timeout=-1s
kubectl wait deploy --all --for condition=Available -n gitlab --timeout=-1s

sleep 42
argocd admin initial-password -n argocd
kubectl exec deploy/gitlab -n gitlab -- grep 'Password:' /etc/gitlab/initial_root_password
