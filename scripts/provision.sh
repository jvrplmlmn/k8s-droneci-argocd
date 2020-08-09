#!/usr/bin/env bash
set -euo pipefail

TIMEOUT="60s"

echo "# Ensuring cert-manager is installed and up-to-date"
kubectl apply -k k8s/cert-manager

echo "# Verifying that the cert-manager deployments are ready before continuining. Will wait ${TIMEOUT}"
kubectl wait \
    --timeout=${TIMEOUT} \
    --for=condition=available \
    deployment.apps \
    -l app.kubernetes.io/instance=cert-manager \
    -n cert-manager
echo

echo "# Ensuring LetsEncrypt issuers are installed and up-to-date"
kubectl apply -k k8s/lets-encrypt

echo "# Verifying that the LetsEncrypt staging issuer is ready before continuining. Will wait ${TIMEOUT}"
kubectl wait \
    --timeout=${TIMEOUT} \
    --for=condition=ready \
    clusterissuer.cert-manager.io/letsencrypt-staging
echo

echo "# Verifying that the LetsEncrypt production issuer is ready before continuining. Will wait ${TIMEOUT}"
kubectl wait \
    --timeout=${TIMEOUT} \
    --for=condition=ready \
    clusterissuer.cert-manager.io/letsencrypt-production
echo

echo "# Ensuring argo-cd is installed and up-to-date"
kubectl apply -k k8s/argocd

echo "# Verifying that the argocd deployments are available before continuining. Will wait ${TIMEOUT}"
kubectl wait \
    --timeout=${TIMEOUT} \
    --for=condition=available \
    deployment.apps \
    -l app.kubernetes.io/part-of=argocd \
    -n argocd

echo "# Ensuring docker-registry is installed and up-to-date"
kubectl apply -k k8s/docker-registry

echo "# Verifying that the docker-registry deployments are available before continuining. Will wait ${TIMEOUT}"
kubectl wait \
    --timeout=${TIMEOUT} \
    --for=condition=available \
    deployment.apps/docker-registry \
    -n docker-registry

echo "# Ensuring drone is installed and up-to-date"
kubectl apply -k k8s/drone

echo "# Verifying that the drone deployments are available before continuining. Will wait ${TIMEOUT}"
kubectl wait \
    --timeout=${TIMEOUT} \
    --for=condition=available \
    deployment.apps \
    -l app.kubernetes.io/name=drone \
    -n drone

echo "# Ensuring foobarqix is installed and up-to-date"
kubectl apply -k k8s/foobarqix