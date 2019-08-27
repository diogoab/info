#!/usr/bin/env bash

sudo apt-get update -y

sudo apt-get install python-setuptools python3 python3-pip curl wget git -y

sudo pip3 install ansible

mkdir -p /home/devops/.ssh

useradd devops -c "Usuário do DevOps" -d /home/devops -s /bin/bash 

echo "devops ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers 

touch /home/devops/.ssh/authorized_keys 

echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAqR1+qsTXwCsLcjbCx9yFiLBB34wH1r5rpnKmn5k/FJwPSpGqC97qxl2QAIvEb0ppBYHQBWCB7JltlkcmHjb7tpC/s65n4w0JBdJkbZ/8jFOY0l4zP/zBPWQqcm8/TEa0ALIh32zbf+DNbjOutvrnnUayk1e9X3u5PH01urZYaARZca0J5M68FtGk1TfIJ0b3TnakLTDD2MpVG+7F7GrKo8iwPdb5rKsh/vQ1bk91PYBCnMd4lAv9kNOHGBK72DR50fycW3ZV0k3b49snyjaYHfYNsBSyuHHCyjm7HQYkbS9MBrnMulYSIQY7v7Ou9lOL9n+S1hRpB7cjhjuuqvHhaw== DevOps" >> /home/devops/.ssh/authorized_keys

chown -R devops:devops /home/devops

swapoff -a

curl https://get.docker.com/ | bash

echo "installing kubernetes"

apt-get update && apt-get install -y apt-transport-https

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update

apt-get install -y kubelet=1.13.5-00 kubeadm=1.13.5-00 kubectl=1.13.5-00

mkdir /home/devops/k8s-cluster
cd /home/devops/k8s-cluster

### Configurando o inventário
cat <<EOF >> /home/devops/k8s-cluster/hosts
[masters]
master ansible_host=k8s-manager ansible_user=root

[workers]
worker1 ansible_host=k8s-worker-1 ansible_user=root
worker2 ansible_host=k8s-worker-2 ansible_user=root
EOF
