FROM debian:bullseye-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    postfix \
    dnsutils \
    procps \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

RUN cp /etc/services /var/spool/postfix/etc/

RUN sed -i '/^myhostname =/d' /etc/postfix/main.cf
RUN sed -i '/^mydestination =/d' /etc/postfix/main.cf
RUN echo 'maillog_file = /dev/stdout' >> /etc/postfix/main.cf

COPY run.sh /run.sh
CMD ["/run.sh"]
