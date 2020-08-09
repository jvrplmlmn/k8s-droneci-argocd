#!/usr/bin/env bash
set -euo pipefail

# Usage:
# env $(cat .secrets | xargs) bash scripts/generate-docker-registry-htpasswd.sh

DOCKER_REGISTRY_USERNAME="${DOCKER_REGISTRY_USERNAME}"
DOCKER_REGISTRY_PASSWORD="${DOCKER_REGISTRY_PASSWORD}"

htpasswd -Bbn "${DOCKER_REGISTRY_USERNAME}" "${DOCKER_REGISTRY_PASSWORD}"
