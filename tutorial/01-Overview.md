# Mission: 

In this tutorial, you will learn how to deploy CAP(Cloud Application Programming) application to Kyma, a managed kubernates runtime in BTP.

# UseCase: Incidents Management

In this tutorial we will use Incident Management as a reference application.

The application allows customers to create incidents, processed by support team members. 
Both add comments to a conversation.
Eventually, a repair appointment is created with a service worker assigned. 

![domain drawio](https://media.github.tools.sap/user/6282/files/7b7d0cee-523c-4b16-950b-de8db2f8e380)


### Setup

```sh
git clone https://github.tools.sap/cap/incidents-mgmt
cd incidents-mgmt
```
```sh
npm i
```

### Run

```sh
cds w
```

### Testing

```sh
npm t
```

### UI Preview
The initial app state does not include dedicated Fiori UIs. However, there is a preview functionality that allows to see dynamically generated UIs.

- Start the application with `cds w`
- Open the server URL : `http://localhost:4004` on the browser
- Click on Fiori Preview e.g. next to Service Endpoint `/incidents` on Entity `Incidents`
- On the authentication popup enter `alice` with no password (if you get a forbidden error and the popup doesn't show try incognito mode or clearing browsing data)

Next: [Deploy Application to Kyma](./02-DeployApplicationToKyma.md)


