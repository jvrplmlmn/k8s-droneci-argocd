#!/usr/bin/env bash
set -euo pipefail

CERT_MANAGER_VERSION="v0.15.1"
CERT_MANAGER_OUTPUT_FILE="upstream/cert-manager-${CERT_MANAGER_VERSION}.yaml"
CERT_MANAGER_URL="https://github.com/jetstack/cert-manager/releases/download/${CERT_MANAGER_VERSION}/cert-manager.yaml"
wget -O "${CERT_MANAGER_OUTPUT_FILE}" "${CERT_MANAGER_URL}"
