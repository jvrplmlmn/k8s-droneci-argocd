# k8s-droneci-argocd
Run a CI/CD stack in Kubernetes composed of a Docker Registry, DroneCI, ArgoCD which deploys a demo app

## Requirements

- A working Kubernetes cluster
- `kubectl`

## Try it out!

1. Replace the placeholders with your values:

```bash
# Create the file
cp .placeholders.tmpl .placeholders
# Edit the contents
vi .placeholders
# Execute the script
env $(cat .placeholders | xargs) bash scripts/replace-placeholders.sh
```

2. Provision the stack

```bash
bash ./scripts/provision.sh
```