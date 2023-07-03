# Continuous Deployment

Continuous deployment is a strategy in software development where code changes to an application are released automatically into the production environment. This automation is driven by a series of predefined tests. Once new updates pass those tests, the system pushes the updates directly to the software's users. It can be achieved by using various tools like Jenkins, Travis CI etc. In this tutorial, we will use GitHub Actions for CD.

GitHub Actions makes it easy to automate all your software workflows, now with world-class CI/CD. Build, test, and deploy your code right from GitHub.

## Set up GitHub Actions

1. Create a folder `.github` and copy the contents of folder `github-workflows` to it.
2. Go to Settings > Secrets and variables > Actions and the following secrets:
    - `IMAGEPULLSECRET`: Secret to pull images from private repository.
    - `IMAGEREGISTRY`: Your private docker registry.
    - `DOCKER_USERNAME`: Docker username required for pushing images to private registry.
    - `DOCKER_PASSWORD`: Docker password required for pushing images to private registry.
    - `KUBE_CONFIG`: Base64 encoded Kubeconfig of technical user. (Follow steps in [this](https://developers.sap.com/tutorials/kyma-create-service-account.html) tutorial for to generate technical user's kubeconfig)
3. Raise the PR to main branch.