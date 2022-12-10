#!/bin/bash

shutdown_handler() {
    child_process_pids=$(pgrep -P $(cat /var/spool/postfix/pid/master.pid))
    postfix stop

    for i in $child_process_pids
    do
        # https://unix.stackexchange.com/questions/103862/how-do-i-wait-on-a-program-started-in-another-shell
        while ps -p "$i" > /dev/null 2>&1
        do
            sleep 0.1
        done
    done
}
trap shutdown_handler SIGTERM

# `/etc/resolv.conf` is rewritten at container startup.
# So, Postfix cannot resolve the name when copied in the Dockerfile.
cp /etc/resolv.conf /var/spool/postfix/etc/

postmap /etc/postfix/transport

postfix start-fg &
wait $!
echo bye
