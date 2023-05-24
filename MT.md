### Add Multitenancy

1. Execute `cds add multitenancy` to add sidecar.

2. Execute `npm install`.

### Build

1. Execute `cds build --production`.

2. Build image for CAP service:

```bash
pack build $YOUR_CONTAINER_REGISTRY/bookshop-srv \
        --path gen/srv \
        --buildpack gcr.io/paketo-buildpacks/nodejs \
        --builder paketobuildpacks/builder:base \
        --env BP_NODE_RUN_SCRIPTS=""
```

(Replace `$YOUR_CONTAINER_REGISTRY` with the full-qualified hostname of your container registry)

3. Build Approuter Image:

```bash
pack build $YOUR_CONTAINER_REGISTRY/bookshop-approuter \
     --path app \
     --buildpack gcr.io/paketo-buildpacks/nodejs \
     --builder paketobuildpacks/builder:base \
     --env BP_NODE_RUN_SCRIPTS=""
```

4. Build sidecar image:

```bash
pack build $YOUR_CONTAINER_REGISTRY/bookshop-sidecar \
     --path gen/mtx/sidecar \
     --buildpack gcr.io/paketo-buildpacks/nodejs \
     --builder paketobuildpacks/builder:base \
     --env BP_NODE_RUN_SCRIPTS=""
```

### Push container images

You can push all the container images to your container registry, using:

```bash
docker push $YOUR_CONTAINER_REGISTRY/bookshop-srv

docker push $YOUR_CONTAINER_REGISTRY/bookshop-approuter

docker push $YOUR_CONTAINER_REGISTRY/bookshop-sidecar
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
helm install bookshop ./chart --set-file xsuaa.jsonParameters=xs-security.json
```