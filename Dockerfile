#
# Dockerfile for besttrace
#

FROM alpine as source

ARG URL=https://cdn.ipip.net/17mon/besttrace4linux.zip

WORKDIR /root

RUN set -ex \
    && apk add --update --no-cache curl \
    && if [ "$(uname -m)" == aarch64 ]; then \
           export BIN='besttracearm'; \
       elif [ "$(uname -m)" == x86_64 ]; then \
           export BIN='besttrace'; \
       fi \
    && curl -OL $URL \
    && unzip -d tmp besttrace4linux.zip \
    && mv tmp/$BIN besttrace \
    && chmod +x besttrace

FROM alpine
COPY --from=source /root/besttrace /usr/local/bin/besttrace

RUN set -ex \
    && apk --update add --no-cache \
       libc6-compat \
       ca-certificates \
    && rm -rf /tmp/* /var/cache/apk/*

ENTRYPOINT ["besttrace"]