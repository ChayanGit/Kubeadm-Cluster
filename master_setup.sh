#!/bin/bash

kubeadm init >> /root/master/initlog

if [$? == 0]
then
    initMasterPane
else
    echo "Master Node not working"
    echo "restart Kubelet and reset kubeadm"
    kubeadm reset -y


initMasterPane (){
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
        
}
kubectl get pods — all-namespaces

if [$? == 0]
then
    kubectl apply -f “https://cloud.weave.works/k8s/net?k8s-v ersion=$(kubectl version | base64 | tr -d ‘\n’)”
else
    echo "core dns nt started"
fi