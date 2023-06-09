# Prepare Kyma Namespace

### Prerequisites

- Command Line Tools: [`kubectl`](https://kubernetes.io/de/docs/tasks/tools/install-kubectl/), [`kubectl-oidc_login`](https://github.com/int128/kubelogin#setup), [`pack`](https://buildpacks.io/docs/tools/pack/), [`docker`](https://docs.docker.com/get-docker/), [`helm`](https://helm.sh/docs/intro/install/)
- `@sap/cds-dk` >= 7.0.1

## Prepare your application for deployment

### Get kubeconfig:


1. Open the [reCAP: Kyma subaccount](https://canary.cockpit.btp.int.sap/cockpit/#/globalaccount/6a8e3c4e-77ea-482c-b37b-4ce687a8bfe0/subaccount/0eef947e-8e50-4ffa-9676-51ae4db1976d/subaccountoverview) and go to the Kyma Environment section.
2. Click on `KubeconfigURL` to download the kubeconfig File.
3. Export the kubeconfig using the command:

    Windows:

    `set KUBECONFIG=<path-to-your-downloaded-file>`.

    macOS:

    `export KUBECONFIG=<path-to-your-downloaded-file>`.

### Prepare Kubernetes Namespace

Change namespace to your own using: `kubectl config set-context --current --namespace=participant-<id>`

#### Create container registry secret


Create a secret `docker-secret` with credentials to access the container registry:

```bash
kubectl create secret docker-registry docker-secret --docker-username=$USERNAME --docker-password=$API_KEY --docker-server=$YOUR_CONTAINER_REGISTRY 
```

This will create a K8s secret, `docker-secret`, in your namespace.


Next: [Containerization](./03-Containerzation.md)