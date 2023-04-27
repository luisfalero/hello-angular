# HelloAngular

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 15.2.7.

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The application will automatically reload if you change any of the source files.

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via a platform of your choice. To use this command, you need to first add a package that implements end-to-end testing capabilities.

## Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI Overview and Command Reference](https://angular.io/cli) page.


# Deploy Openshift

Add **Dockerfile** and **nginx.conf**

## Local

```shell
podman login -u rh_ee_lfalero https://registry.access.redhat.com
```

```shell
podman pull registry.access.redhat.com/ubi8/nodejs-16:1-98
```

```shell
podman pull registry.access.redhat.com/ubi8/nginx-120:1-100
```

```shell
podman images
```

```shell
podman build -t rh_ee_lfalero/hello-angular:1.0.0 .
```

```shell
podman run -d --name hello-angular -p 8888:8080 rh_ee_lfalero/hello-angular:1.0.0
```

Browser it http://localhost:8888/

## Openshift

```shell
oc new-project angular
```

```shell
oc new-app --name hello-angular \
  https://github.com/luisfalero/hello-angular.git \
  --strategy=docker --as-deployment-config
```

```shell
oc create route edge --service hello-angular
```

Browser it

```shell
oc get route/hello-angular -o jsonpath='{.spec.host}'
```