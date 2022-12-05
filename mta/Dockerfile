FROM debian:bullseye-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    postfix \
    dnsutils \
    procps \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

RUN cp /etc/services /var/spool/postfix/etc/

COPY main.cf /etc/postfix/main.cf
COPY transport /etc/postfix/transport

COPY master.cf /etc/postfix/master.cf
RUN useradd -m pipe-test
COPY pipe-test.sh /pipe-test.sh

