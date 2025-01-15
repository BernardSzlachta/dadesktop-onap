#!/bin/bash -x
#git clone http://gerrit.onap.org/r/oom

#helm plugin install oom/kubernetes/helm/plugins/deploy
#helm plugin install oom/kubernetes/helm/plugins/undeploy
#kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
#helm repo add strimzi https://strimzi.io/charts/
#helm install strimzi-kafka-operator strimzi/strimzi-kafka-operator --namespace strimzi-system --version 0.41.0 --set watchAnyNamespace=true --create-namespace
#kubectl get po -n strimzi-system
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.14.4/cert-manager.yaml
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update
kubectl create namespace istio-config

kubectl create namespace istio-system
helm upgrade -i istio-base istio/base -n istio-system --version 1.21.0
