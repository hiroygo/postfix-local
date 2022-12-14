FROM debian:bullseye-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    postfix \
    dnsutils \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

RUN sed -i '/^myhostname =/d' /etc/postfix/main.cf
RUN sed -i '/mydestination =/c mydestination = $myhostname' /etc/postfix/main.cf
RUN echo 'maillog_file = /dev/stdout' >> /etc/postfix/main.cf
