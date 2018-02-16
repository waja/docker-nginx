FROM alpine:3.7

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

ARG "BUILD_DATE=unknown"
ARG "BUILD_VERSION=unknown"
ARG "VCS_URL=unknown"
ARG "VCS_REF=unknown"
ARG "VCS_BRANCH=unknown"

# See http://label-schema.org/rc1/ and https://microbadger.com/labels
LABEL org.label-schema.name="Nginx webserver" \
    org.label-schema.description="Alpine Linux container with installed nginx package" \
    org.label-schema.vendor="Cyconet" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.version=$BUILD_VERSION \
    org.label-schema.vcs-url=$VCS_URL \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-branch=$VCS_BRANCH

RUN apk --no-cache update && apk --no-cache upgrade && \
    # Install needed packages
    apk add --update --no-cache nginx && rm -rf /var/cache/apk/* && \
    # create needed directories
    mkdir -p /run/nginx/ && \
    # forward request and error logs to docker log collector
    # See https://github.com/moby/moby/issues/19616
    ln -sf /proc/1/fd/1 /var/log/nginx/access.log && \
    ln -sf /proc/1/fd/1 /var/log/nginx/error.log

EXPOSE 80 443
STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
