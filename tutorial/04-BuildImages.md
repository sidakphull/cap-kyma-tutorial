# Containerizing a CAP Application

## Overview

A CAP Application (single) usually has three modules:
- Backend (srv)
- DB Deployer
- Frontend (Approuter or HTML5 App Deployer)

## Build Application

Execute the following command to build your modules:

```bash
cds build --production
```

## Docker login

Login to docker using the following command:

```bash
docker login -u "$USERNAME" -p "$API_KEY" $YOUR_CONTAINER_REGISTRY
```

## Containerize

**Build image for CAP service:**

```bash
pack build $YOUR_CONTAINER_REGISTRY/recap/{Participant_ID}/bookshop-srv \
        --path gen/srv \
        --buildpack gcr.io/paketo-buildpacks/nodejs \
        --builder paketobuildpacks/builder:base \
        --env BP_NODE_RUN_SCRIPTS=""
```


(Replace `$YOUR_CONTAINER_REGISTRY` with the full-qualified hostname of your container registry)

**Build Approuter Image:**

```bash
pack build $YOUR_CONTAINER_REGISTRY/recap/{Participant_ID}/bookshop-approuter \
     --path app \
     --buildpack gcr.io/paketo-buildpacks/nodejs \
     --builder paketobuildpacks/builder:base \
     --env BP_NODE_RUN_SCRIPTS=""
```

**Build database deployer image:**

```bash
pack build $YOUR_CONTAINER_REGISTRY/recap/{Participant_ID}/bookshop-hana-deployer \
     --path gen/db \
     --buildpack gcr.io/paketo-buildpacks/nodejs \
     --builder paketobuildpacks/builder:base \
     --env BP_NODE_RUN_SCRIPTS=""
```

### Push container images

You can push all the container images to your container registry, using:

```bash
docker push $YOUR_CONTAINER_REGISTRY/recap/{Participant_ID}/bookshop-srv

docker push $YOUR_CONTAINER_REGISTRY/recap/{Participant_ID}/bookshop-approuter

docker push $YOUR_CONTAINER_REGISTRY/recap/{Participant_ID}/bookshop-hana-deployer
```