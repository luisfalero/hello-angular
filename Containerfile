FROM registry.access.redhat.com/ubi8/nodejs-16:1-98 as build-stage
ARG FILE=/urs/src/app
WORKDIR $FILE
COPY package.json package-lock.json ./
USER root
RUN npm install
COPY . .
RUN npm run build
RUN chmod 644 $FILE
USER 1001

FROM registry.access.redhat.com/ubi8/nginx-120:1-100
ARG FILE=/urs/src/app
ARG PROJECT=hello-angular
COPY --from=build-stage $FILE/dist/$PROJECT/ .
ADD ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
USER 1001