# Prepare Kyma Namespace

### Prerequisites

- Command Line Tools: [`kubectl`](https://kubernetes.io/de/docs/tasks/tools/install-kubectl/), [`kubectl-oidc_login`](https://github.com/int128/kubelogin#setup), [`pack`](https://buildpacks.io/docs/tools/pack/), [`docker`](https://docs.docker.com/get-docker/), [`helm`](https://helm.sh/docs/intro/install/)
- `@sap/cds-dk` >= 6.8.3

## Prepare your application for deployment

### Get kubeconfig:


1. Open the reCAP: Kyma subaccount and go to the Kyma Environment section.
2. Click on `KubeconfigURL` to download the kubeconfig File.
3. Export the kubeconfig using the command `set KUBECONFIG=<path-to-your-downloaded-file>`.

### Prepare Kubernetes Namespace

Change namespace to your own using: `kubectl config set-context --current --namespace=participant-<id>`

#### Create container registry secret


Create a secret `container-registry` with credentials to access the container registry:

```bash
kubectl create secret docker-registry docker-secret --docker-username=$USERNAME --docker-password=$API_KEY --docker-server=$YOUR_CONTAINER_REGISTRY 
```

This will create a K8s secret, `docker-secret`, in your namespace.


// TODO: Explain about HANA Cloud Instance mapping to Kyma https://blogs.sap.com/2022/12/15/consuming-sap-hana-cloud-from-the-kyma-environment/