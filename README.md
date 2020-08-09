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

## Clarifications

### LetsEncrypt

Since we use LetsEncrypt to manage the SSL certificates, be wary of the [rate-limits](https://letsencrypt.org/docs/rate-limits/).

You can verify the status of the orders with:

```bash
kubectl describe order --all-namespaces=true
```

Here is an example output snippet of being rate limited:

```
$ kubectl describe order --all-namespaces=true
(...)
  Issuer Ref:
    Group:  cert-manager.io
    Kind:   ClusterIssuer
    Name:   letsencrypt-production
Status:
  Failure Time:  2020-08-09T22:21:17Z
  Reason:        Failed to create Order: 429 urn:ietf:params:acme:error:rateLimited: Error creating new order :: too many certificates already issued for exact set of domains: example.com: see https://letsencrypt.org/docs/rate-limits/
  State:         errored
Events:          <none>
```
