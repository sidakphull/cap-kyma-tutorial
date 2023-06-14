# Deploy Application to Kyma

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

#### Map your HANA Cloud Instance to your Kyma Cluster

Follow the instructions in [this](https://blogs.sap.com/2022/12/15/consuming-sap-hana-cloud-from-the-kyma-environment/) blog and add a mapping to you Kyma namespace in your HANA Cloud Instance.

### Build

```bash
cds build --production
```

**Build image for CAP service:**

```bash
pack build $YOUR_CONTAINER_REGISTRY/bookshop-{Participant_ID}-srv \
        --path gen/srv \
        --buildpack gcr.io/paketo-buildpacks/nodejs \
        --builder paketobuildpacks/builder:base \
        --env BP_NODE_RUN_SCRIPTS=""
```

(Replace `$YOUR_CONTAINER_REGISTRY` with the full-qualified hostname of your container registry)

**Build Approuter Image:**

```bash
pack build $YOUR_CONTAINER_REGISTRY/bookshop-{Participant_ID}-approuter \
     --path app \
     --buildpack gcr.io/paketo-buildpacks/nodejs \
     --builder paketobuildpacks/builder:base \
     --env BP_NODE_RUN_SCRIPTS=""
```

**Build database deployer image:**

```bash
pack build $YOUR_CONTAINER_REGISTRY/bookshop-{Participant_ID}-hana-deployer \
     --path gen/db \
     --buildpack gcr.io/paketo-buildpacks/nodejs \
     --builder paketobuildpacks/builder:base \
     --env BP_NODE_RUN_SCRIPTS=""
```

### Push container images

You can push all the container images to your container registry, using:

```bash
docker push $YOUR_CONTAINER_REGISTRY/bookshop-{Participant_ID}-srv

docker push $YOUR_CONTAINER_REGISTRY/bookshop-{Participant_ID}-approuter

docker push $YOUR_CONTAINER_REGISTRY/bookshop-{Participant_ID}-hana-deployer
```

### Deploy

Add Helm Chart

```bash
cds add helm
```

Make the following changes in the _`chart/values.yaml`_ file.

1. Change value of `global.domain` key to your cluster domain.

2. Replace `<your-cluster-domain>` in `xsuaa.parameters.oauth2-configuration.redirect-uris` with your cluster domain.

3. Replace `<your-container-registry>` with your container registry.

4. Make the following change to add backend destinations required by Approuter.
   
```diff
-  backendDestinations: {}
+  backendDestinations:
+     srv-api:
+       service: srv
```

5. Add your image registry secret created in [Create container registry secret](#create-container-registry-secret) step.

```diff
global:
  domain: null
-  imagePullSecret: {}
+  imagePullSecret:
+    name: container-registry
```

6. Install the helm chart with the following command:

```bash
helm install bookshop--{Participant_ID} ./chart --set-file xsuaa.jsonParameters=xs-security.json
```