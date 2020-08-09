#!/usr/bin/env bash
set -euo pipefail

LETSENCRYPT_EMAIL="${LETSENCRYPT_EMAIL}"

grep "___PLACEHOLDER_LETSENCRYPT_EMAIL___" -rl k8s | xargs \
    sed -i "s/___PLACEHOLDER_LETSENCRYPT_EMAIL___/${LETSENCRYPT_EMAIL}/g"
