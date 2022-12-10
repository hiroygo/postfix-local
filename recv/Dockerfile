FROM debian:bullseye-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    postfix \
    dnsutils \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

COPY main.cf /etc/postfix/main.cf
