# Multitenancy

Multitenancy is the ability to serve multiple tenants through single clusters of microservice instances, while strictly isolating the tenants' data.
In contrast to single-tenant mode, applications aren't serving end-user request immediately after deployment, but wait for tenants to subscribe.
CAP has built-in support for multitenancy with the @sap/cds-mtxs package.

## Make CAP Application Multitenant

Uninstall the single tenant version be executing the following command:

```bash
helm uninstall bookshop-{Participant_ID}
```

Create a new branch `multitenant` in your forked repo using the following command:

```bash
git checkout -b multitenant
```

Execute the following command to make the app multitenant:

```bash
cds add mtx --for production
```

`Note`: Make sure you install the newly added dependencies by executing `npm i`.

## Changes to values.yaml

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

2. Add the `mtx-api` destination in `backendDestinations` key:

        ```diff
        backendDestinations:
          srv-api:
            service: srv
        +  mtx-api:
        +    service: sidecar
        ```

3. Raise a PR to the `main` branch of your repository and merge it. This will start the deployment workflow and upgrade your application.

## Changes to GitHub Actions Workflow

Replace the content of `.github/actions/deploy/action.yml` with `files/mt-action.yaml`.

`Note:` Make sure you update your participant id again in the `action.yml`.

## Access

1. Open the [reCAP:Kyma subaccount](https://canary.cockpit.btp.int.sap/cockpit/#/globalaccount/6a8e3c4e-77ea-482c-b37b-4ce687a8bfe0/subaccount/0eef947e-8e50-4ffa-9676-51ae4db1976d/subaccountoverview) and go to `Instances and Subscriptions` tab.
2. Click on `Create`.
3. Search for `bookshop-<participantID>` and select the default plan.
4. Click on `Create`.
5. Once the subscription is successful, click on `Go to Application`.
6. You'll get an error saying, `No webpage was found for the web address: ....` The web address should be of the form: `https://<your-host>.c-4e4de85.stage.kyma.ondemand.com`. Copy the `your-host` value. You'll need it in the next step.
7. Configure your participant id, host and release name in the `api-rule.yaml` file available in the `files` folder of your fork.
8. Apply it using the following command `kubectl apply -f files/api-rule.yaml`.
8. Open the web address.
