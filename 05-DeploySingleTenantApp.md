# Deploy to Kyma

## Add Helm Chart

```bash
cds add helm
```

## Configure Helm Chart

Make the following changes in the _`chart/values.yaml`_ file.

1. Change value of `global.domain` key to your cluster domain. 

    Execute the following command to find out your cluster domain:

    ```bash
    kubectl get gateway -n kyma-system kyma-gateway -o jsonpath='{.spec.servers[0].hosts[0]}'
    ```

    Result should be something like:
    ```bash
    *.<xyz123>.kyma.ondemand.com%
    ```

    Your cluster domain is: `<xyz123>.kyma.ondemand.com`

2. Replace `<your-cluster-domain>` in `xsuaa.parameters.oauth2-configuration.redirect-uris` with your cluster domain.

3. Replace `xsuaa.xsappname` with `bookshop-{Participant_ID}`.

4. Update image links for approuter,srv and db-deployer.

5. Make the following change to add backend destinations required by Approuter.
   
    ```diff
    -  backendDestinations: {}
    +  backendDestinations:
    +     srv-api:
    +       service: srv
    ```

6. Add your image registry secret.

    ```diff
    global:
      domain: <xyz123>.kyma.ondemand.com
    -  imagePullSecret: {}
    +  imagePullSecret:
    +    name: docker-secret
    ```

7. Install the helm chart with the following command:

    ```bash
    helm install bookshop-{Participant_ID} ./chart --set-file xsuaa.jsonParameters=xs-security.json
    ```

Next: [Continuous Deployment using GitHub Actions](./06-GithubActions.md)