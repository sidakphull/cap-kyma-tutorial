# Multitenancy

// explain

## Make CAP Application Multitenant

Execute the following command to make the app multitenant:

```bash
cds add multitenancy --for production
```

`Note`: Make sure you install the newly added dependencies by executing `npm i`.

## Build & Containerize

Execute the following command to build the app:

```bash
cds build --production
```

(Make sure you execute `npm i` after executing the above command.)

**Build image for CAP service:**

```bash
pack build $YOUR_CONTAINER_REGISTRY/recap/{Participant_ID}/mt/bookshop-srv \
        --path gen/srv \
        --buildpack gcr.io/paketo-buildpacks/nodejs \
        --builder paketobuildpacks/builder:base \
        --env BP_NODE_RUN_SCRIPTS=""
```

**Build image for MTXS Sidecar:**

```bash
pack build $YOUR_CONTAINER_REGISTRY/recap/{Participant_ID}/bookshop-sidecar \
        --path gen/mtx/sidecar \
        --buildpack gcr.io/paketo-buildpacks/nodejs \
        --builder paketobuildpacks/builder:base \
        --env BP_NODE_RUN_SCRIPTS=""
```

**Push images:**

```bash
docker push $YOUR_CONTAINER_REGISTRY/recap/{Participant_ID}/bookshop-srv

docker push $YOUR_CONTAINER_REGISTRY/recap/{Participant_ID}/bookshop-sidecar
```

## Deploy

1. Update values of the following keys of `saasRegistryParameters`:

        ```diff
        saasRegistryParameters:
        -  xsappname: bookshop
        -  appName: bookshop
        -  displayName: bookshop
        +  xsappname: bookshop-{Participant_ID}
        +  appName: bookshop-{Participant_ID}
        +  displayName: bookshop-{Participant_ID}
        ```

2. Uninstall the single tenant version be executing the following command:

        ```bash
        helm uninstall bookshop-{Participant_ID}
        ```

3. Raise a PR to the `main` branch of your repository and merge it. This will start the deployment workflow and upgrade your application.

## Access

1. Open the [reCAP:Kyma subaccount](https://canary.cockpit.btp.int.sap/cockpit/#/globalaccount/6a8e3c4e-77ea-482c-b37b-4ce687a8bfe0/subaccount/0eef947e-8e50-4ffa-9676-51ae4db1976d/subaccountoverview) and go to `Instances and Subscriptions` tab.
2. Click on `Create`.
3. Search for `bookshop-<participantID>` and select the default plan.
4. Click on `Create`.
5. Once the subscription is successful, click on `Go to Application`.

6. You'll get an error saying, `No webpage was found for the web address: ....` The web address should be of the form: `https://<your-host>.c-4e4de85.stage.kyma.ondemand.com`. Copy the `your-host` value. You'll need it in the next step.

7. Make changes to the [api-rule.yaml](./../files/api-rule.yaml) file and apply it using the following command `kubectl apply -f files/api-rule.yaml`.
8. Open the web address.