
DOCKER_ACCOUNT=cap-dev.common.repositories.cloud.sap/sidak/recap

build:
	cds build --production

build-dbimage:
	pack build incidents-mgmt-hana-deployer --path gen/db --buildpack gcr.io/paketo-buildpacks/nodejs --builder paketobuildpacks/builder:base --env BP_NODE_RUN_SCRIPTS=""
	docker tag incidents-mgmt-hana-deployer:latest $(DOCKER_ACCOUNT)/incidents-mgmt-hana-deployer:latest

build-srv:
	pack build incidents-mgmt-srv --path gen/srv --buildpack gcr.io/paketo-buildpacks/nodejs --builder paketobuildpacks/builder:base --env BP_NODE_RUN_SCRIPTS=""
	docker tag incidents-mgmt-srv:latest $(DOCKER_ACCOUNT)/incidents-mgmt-srv:latest

build-uiimage:
	pack build incidents-mgmt-approuter --path app --buildpack gcr.io/paketo-buildpacks/nodejs --builder paketobuildpacks/builder:base --env BP_NODE_RUN_SCRIPTS=""
	docker tag incidents-mgmt-approuter:latest $(DOCKER_ACCOUNT)/incidents-mgmt-approuter:latest

push-images: build build-dbimage build-srv build-uiimage
	docker push $(DOCKER_ACCOUNT)/incidents-mgmt-hana-deployer:latest
	docker push $(DOCKER_ACCOUNT)/incidents-mgmt-srv:latest
	docker push $(DOCKER_ACCOUNT)/incidents-mgmt-approuter:latest