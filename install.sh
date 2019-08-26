#!/usr/bin/env bash

sudo apt-get update -y

sudo apt-get install python-setuptools python3 python3-pip curl wget git -y

sudo pip3 install ansible

mkdir -p /home/devops/.ssh

useradd devops -c "Usuário do DevOps" -d /home/devops -s /bin/bash 

echo "devops ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers 

touch /home/devops/.ssh/authorized_keys 

echo "ssh-rsa ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDATBkkYxFUTsjJ9WpKkddT0a+mcnoTu0/uH5YbjRPiNT787fwJ+AIEAQ6yfzgRx42xYHNZvdIbB5A5YfJNkaVNrRhromM1GtayHm8Q4sitSeoZUyFw4omigU9EWiyllG5SQfM8n9NBF1bGCM30DiIL6gtzKMepUpQlyqgdNgF15asL7vQ6mJEvw1HEkD6FbjCjY2v/XeADvORHjfj0AugbePyFeay+HdXRC3gSBQaZATWCN2UqMR4Y87KPG4DYHqL5rzCJkcC+U2LBQgwcUNRawCnWleKn0K7E5O+LjWV0y7/lkFyy4VMdPqRqSe11lsBvrCX+2kjnnKWi7g0JQpf3 DevOps-Everis" >> /home/devops/.ssh/authorized_keys

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
cat <<EOF >> ~/k8s-cluster/hosts
[masters]
master ansible_host=k8s-manager ansible_user=root

[workers]
worker1 ansible_host=k8s-worker1 ansible_user=root
worker2 ansible_host=k8s-worker2 ansible_user=root
EOF
