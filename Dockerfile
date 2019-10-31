FROM node:12.13.0-alpine

LABEL maintainer="Daniel Sánchez Navarro <dansanav@gmail.com>"

ENV KUBE_LATEST_VERSION=v.15.0
ENV DANTE_CLI_VERSION v0.0.5

RUN apk add --update ca-certificates openssl git \
 && apk add --update -t deps curl  \
 && apk add --update gettext tar gzip build-base py3-setuptools \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && pip3 install awscli --upgrade \
 && apk del --purge deps \
 && rm /var/cache/apk/*


ENV DANTE_CLI_VERSION v0.0.5
ENV DANTE_CLI_DOWNLOAD_URL https://github.com/jhidalgo3/dante-cli/releases/download/$DANTE_CLI_VERSION/dante-cli-alpine-linux-amd64-$DANTE_CLI_VERSION.tar.gz

RUN echo $DANTE_CLI_DOWNLOAD_URL

RUN wget -qO- $DANTE_CLI_DOWNLOAD_URL | tar xvz -C /usr/local/bin

CMD ["kubectl"]
