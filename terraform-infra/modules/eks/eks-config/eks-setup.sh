#!/bin/bash
sudo apt update
sudo apt upgrade -y

# Install container runtime
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker

# Install kubeadm, kubelet and kubectl
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl
sudo curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt update
sudo apt install -y kubeadm kubelet kubectl

# check if swap is enabled: Kubernetes requires swap to be disabled on the host system.
sudo swapon --show

# Disable swap temporarily
sudo swapoff -a

# Initialize the cluster
sudo kubeadm init

# configure kubeconfig
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


# Apply Pod network add-on, using calico
kubectl apply -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml















wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install -y jenkins
sudo systemctl start jenkins