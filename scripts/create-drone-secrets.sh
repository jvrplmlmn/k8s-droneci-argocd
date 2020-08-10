#!/usr/bin/env bash
set -euo pipefail

# Usage:
# 
# env $(cat k8s/secrets/secrets.env | xargs) bash ./k8s/create-drone-secrets.sh
#
#

DRONE_SERVER="${DRONE_SERVER}"
DRONE_TOKEN="${DRONE_TOKEN}"
GITHUB_ORG="${GITHUB_ORG}"
GITHUB_REPO="${GITHUB_REPO}"
DOCKER_REGISTRY_USERNAME="${DOCKER_REGISTRY_USERNAME}"
DOCKER_REGISTRY_PASSWORD="${DOCKER_REGISTRY_PASSWORD}"

echo "${DOCKER_REGISTRY_USERNAME} / ${DOCKER_REGISTRY_PASSWORD}"

DOCKER_USERNAME_SECRET_NAME="docker_username"
DOCKER_PASSWORD_SECRET_NAME="docker_password"

if drone secret info --repository "${GITHUB_ORG}/${GITHUB_REPO}" --name "${DOCKER_USERNAME_SECRET_NAME}" &>/dev/null; then
    echo "Updating secret ${DOCKER_USERNAME_SECRET_NAME} in repository ${GITHUB_ORG}"/"${GITHUB_REPO}"
    drone secret update \
        --repository "${GITHUB_ORG}/${GITHUB_REPO}" \
        --name "${DOCKER_USERNAME_SECRET_NAME}" \
        --data "${DOCKER_REGISTRY_USERNAME}"
else
    echo "Adding secret ${DOCKER_USERNAME_SECRET_NAME} to repository ${GITHUB_ORG}"/"${GITHUB_REPO}"
    drone secret add \
        --repository "${GITHUB_ORG}/${GITHUB_REPO}" \
        --name "${DOCKER_USERNAME_SECRET_NAME}" \
        --data "${DOCKER_REGISTRY_USERNAME}"
fi

if drone secret info --repository "${GITHUB_ORG}/${GITHUB_REPO}" --name "${DOCKER_PASSWORD_SECRET_NAME}" &>/dev/null; then
    echo "Updating secret ${DOCKER_PASSWORD_SECRET_NAME} in repository ${GITHUB_ORG}"/"${GITHUB_REPO}"
    drone secret update \
        --repository "${GITHUB_ORG}/${GITHUB_REPO}" \
        --name "${DOCKER_PASSWORD_SECRET_NAME}" \
        --data "${DOCKER_REGISTRY_PASSWORD}"
else
    echo "Adding secret ${DOCKER_PASSWORD_SECRET_NAME} to repository ${GITHUB_ORG}"/"${GITHUB_REPO}"
    drone secret add \
        --repository "${GITHUB_ORG}/${GITHUB_REPO}" \
        --name "${DOCKER_PASSWORD_SECRET_NAME}" \
        --data "${DOCKER_REGISTRY_PASSWORD}"
fi

