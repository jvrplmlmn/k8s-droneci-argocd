#!/usr/bin/env bash
set -euo pipefail

helm repo add drone https://charts.drone.io
helm repo update

helm template \
    drone \
    drone/drone \
    -f helm/drone-server-values.yaml \
    --version 0.1.6 > drone.yaml
helm template \
    drone-runner-kube \
    drone/drone-runner-kube \
    -f helm/drone-runner-kube-values.yaml \
    --version 0.1.3 > drone-runner-kube.yaml
