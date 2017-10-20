FROM node:7-alpine

MAINTAINER "Jose Maria Hidalgo Garcia <jhidalgo3@gmail.com>

ENV KUBE_LATEST_VERSION=v1.7.7
ENV HELM_VERSION=v2.6.1
ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz


RUN apk add --update ca-certificates openssl git \
 && apk add --update -t deps curl  \
 && apk add --update gettext tar gzip build-base perl python \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && curl -L https://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME} | tar xz && mv linux-amd64/helm /bin/helm && rm -rf linux-amd64 \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*


ENV DANTE_CLI_VERSION v0.0.5
ENV DANTE_CLI_DOWNLOAD_URL https://github.com/jhidalgo3/dante-cli/releases/download/$DANTE_CLI_VERSION/dante-cli-alpine-linux-amd64-$DANTE_CLI_VERSION.tar.gz

RUN echo $DANTE_CLI_DOWNLOAD_URL

RUN wget -qO- $DANTE_CLI_DOWNLOAD_URL | tar xvz -C /usr/local/bin

CMD ["kubectl"]
