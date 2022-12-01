#!/bin/bash

trap 'postfix stop' SIGTERM

# `/etc/resolv.conf` is rewritten at container startup.
# So, Postfix cannot resolve the name when copied in the Dockerfile.
cp /etc/resolv.conf /var/spool/postfix/etc/

postmap /etc/postfix/transport

postfix start-fg &
wait $!
echo bye
