#
# Dockerfile for besttrace
#

FROM alpine:latest

ARG DL_URL="https://cdn.ipip.net/17mon/besttrace4linux.zip"

WORKDIR /etc/besttrace

RUN set -ex \
    && apk --update add --no-cache \
       libc6-compat \
       ca-certificates \
    && wget $DL_URL \
    && unzip besttrace4linux.zip "besttrace" \
    && chmod +x besttrace \
    && rm -rf besttrace4linux.zip \
    && rm -rf /var/cache/apk

ENV PATH /etc/besttrace:$PATH

ENTRYPOINT ["besttrace"]