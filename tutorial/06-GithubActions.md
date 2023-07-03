# Continuous Deployment using GitHub Actions

Continuous deployment is a strategy in software development where code changes to an application are released automatically into the production environment. This automation is driven by a series of predefined tests. Once new updates pass those tests, the system pushes the updates directly to the software's users. It can be achieved by using various tools like Jenkins, Travis CI etc. In this tutorial, we will use GitHub Actions for CD.

GitHub Actions makes it easy to automate all your software workflows, now with world-class CI/CD. Build, test, and deploy your code right from GitHub.

## Set up GitHub Actions

### Create token for Technical User

1. Make the required changes to the [service-account.yaml](../files/service-account.yaml) file.
2. Apply the file using the command `kubectl apply -f ./files/service-account.yaml`.

    This will create a service account resource and give it permissions to manipulate all the resources in your namespace. In contrast to the kubeconfig file from the Kyma dashboard, this token is not based on a user and is well-suited for scenarios like CI/CD pipelines.

3. Make the required changes to the [kubeconfig.sh](../files/kubeconfig.sh) file.
4. Execute the script using the command `bash files/kubeconfig.sh`.
5. The script will output a base64 encoded token which you can use as a secret in your workflows in the next step.

### Automatic Workflows

1. Create a folder `.github` and copy the contents of folder `github-workflows` to it.
2. Go to Settings > Secrets and variables > Actions and the following secrets:
    - `IMAGEPULLSECRET`: Secret to pull images from private repository.
    - `IMAGEREGISTRY`: Your private docker registry.
    - `DOCKER_USERNAME`: Docker username required for pushing images to private registry.
    - `DOCKER_PASSWORD`: Docker password required for pushing images to private registry.
    - `KUBE_CONFIG`: Base64 encoded Kubeconfig of technical user created in [previous](#create-token-for-technical-user) step.
3. Push the code to the main branch.

Next: [Multitenancy](./07-Mulititenancy.md)