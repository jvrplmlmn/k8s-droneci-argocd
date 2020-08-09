#!/usr/bin/env bash
set -euo pipefail

DRONE_RPC_SECRET="${DRONE_RPC_SECRET}"
DRONE_GITHUB_CLIENT_ID="${DRONE_GITHUB_CLIENT_ID}"
DRONE_GITHUB_CLIENT_SECRET="${DRONE_GITHUB_CLIENT_SECRET}"

DOCKER_REGISTRY_HTPASSWD="${DOCKER_REGISTRY_HTPASSWD}"
DOCKER_REGISTRY_HA_SHARED_SECRET="${DOCKER_REGISTRY_HA_SHARED_SECRET}"

# Populate Drone secrets
cat <<EOF > k8s/drone/secret/drone-rpc
DRONE_RPC_SECRET=${DRONE_RPC_SECRET}
EOF

cat <<EOF > k8s/drone/secret/drone-github-client
DRONE_GITHUB_CLIENT_ID=${DRONE_GITHUB_CLIENT_ID}
DRONE_GITHUB_CLIENT_SECRET=${DRONE_GITHUB_CLIENT_SECRET}
EOF

# Populate Docker secrets
echo "${DOCKER_REGISTRY_HTPASSWD}" > k8s/docker-registry/secret/docker-registry.htpasswd
echo "${DOCKER_REGISTRY_HA_SHARED_SECRET}" > k8s/docker-registry/secret/docker-registry.haSharedSecret