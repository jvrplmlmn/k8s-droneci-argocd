# k8s-droneci-argocd
Run a CI/CD stack in Kubernetes composed of a Docker Registry, DroneCI, ArgoCD which deploys a demo app

## Requirements

- A working Kubernetes cluster with `ingress-nginx`.
  Since this is provider specific, make sure to follow https://kubernetes.github.io/ingress-nginx/deploy/
- DNS records for (replace `example.com` with your domain):
  - Drone: `drone.example.com`
  - Docker Registry: `registry.example.com`
  - Demo app (FooBarQix): `example.com`
- `kubectl`: Required to manage the Kubernetes resources
- `htpasswd`: Required to generate the auth of the Docker Registry

Optional, required to update some manifests:
- `helm`

## Try it out!

1. Replace the placeholders with your values:

```bash
# Create the file (its gitignored)
cp .placeholders.tmpl .placeholders
# Edit the contents
vi .placeholders
# Execute the script
env $(cat .placeholders | xargs) bash scripts/replace-placeholders.sh
```

2. Set up your secrets:

```bash
# Create the file (its gitignored)
cp .secrets.tmpl .secrets
# Edit the contents
vi .placeholders
# Execute the script
env $(cat .secrets | xargs) bash scripts/populate-secrets.sh
```

3. Provision the stack

```bash
bash ./scripts/provision.sh
```