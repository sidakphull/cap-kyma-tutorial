# Containerization

Containerization is a software deployment process that bundles an application's code with all the files and libraries it needs to run on any infrastructure. It allows developers to create and deploy applications faster and more securely. [Read more about benefits of containerization.](https://www.ibm.com/cloud/blog/the-benefits-of-containerization-and-what-it-means-for-you)

We will use [Cloud Native Buildpacks](https://buildpacks.io/) to containerize our CAP application. Cloud Native Buildpacks transform your application source code into container images that can run on any cloud. They also provide other features like:

- Advanced Caching: Robust caching is used to improve performance.
- Auto-detection: Images can be built directly from application source without additional instructions.
- Multi-language: Supports more than one programming language family.
- Minimal app image: Image contains only what is necessary.

and [many more...](https://buildpacks.io/features/)