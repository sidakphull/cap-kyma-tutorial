# Prepare Kyma Namespace

### Prerequisites

- BTP Subaccount with Kyma Runtime
- BTP Subaccount with Cloud Foundry Space
- [HANA Cloud instance available](https://developers.sap.com/tutorials/hana-cloud-deploying.html) for your Cloud Foundry space
- BTP Entitlements for: *HANA HDI Services & Container* plan *hdi-shared*
- Container Registry (e.g. [Docker Hub](https://hub.docker.com/))
- Command Line Tools: [`kubectl`](https://kubernetes.io/de/docs/tasks/tools/install-kubectl/), [`kubectl-oidc_login`](https://github.com/int128/kubelogin#setup), [`pack`](https://buildpacks.io/docs/tools/pack/), [`docker`](https://docs.docker.com/get-docker/), [`helm`](https://helm.sh/docs/intro/install/), [`cf`](https://docs.cloudfoundry.org/cf-cli/install-go-cli.html)
- Logged into Kyma Runtime (with `kubectl` CLI), Cloud Foundry space (with `cf` CLI) and Container Registry (with `docker login`)
- `@sap/cds-dk` >= 6.8.1

## Prepare your application for deployment

### Load kubeConfig file for Kyma Cluster:
//TODO: Provide the kubeconfig file link here for the cluster

// Add command to list all the namespaces: 

// Set the namespace with the participantID
// Export all the variables that are required from the participant key.

### Prepare Kubernetes Namespace
Your namespace will be <ParticipantID> provided to you by your trainer!

#### Create container registry secret


Create a secret `container-registry` with credentials to access the container registry:
// TODO: Add namespace command here:
// Add command to load kubectl clusters: 

// Talk about deployment services
// Add about Helm charts and what it Does!
// Talk about CDS plug and play facets
// Talk about roles that is required

```bash
kubectl create secret docker-registry docker-secret --docker-username=$USERNAME --docker-password=$API_KEY --docker-server=$YOUR_CONTAINER_REGISTRY 
```

This will create a K8s secret, `docker-secret`, in your namespace.


// TODO: Explain about HANA Cloud Instance mapping to Kyma https://blogs.sap.com/2022/12/15/consuming-sap-hana-cloud-from-the-kyma-environment/