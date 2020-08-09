#!/usr/bin/env bash
set -euo pipefail

helm template \
    docker-registry \
    stable/docker-registry \
    -f helm/docker-registry-values.yaml \
    --version 1.9.4 > docker-registry.yaml
git apply docker-registry.yaml.patch