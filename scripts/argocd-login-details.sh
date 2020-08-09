#!/usr/bin/env bash
set -euo pipefail

ARGOCD_NAMESPACE="argocd"
ARGOCD_USERNAME="admin"
ARGOCD_PASSWORD=$(kubectl get pods -n "${ARGOCD_NAMESPACE}" -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2)
echo "# ArgoCD login information:"
echo "User: ${ARGOCD_USERNAME}"
echo "Password: ${ARGOCD_PASSWORD}"

echo "Port forwarding, go to http://localhost:8080"
kubectl port-forward svc/argocd-server -n "${ARGOCD_NAMESPACE}" 8080:443
