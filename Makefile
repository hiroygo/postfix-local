recv := recv.localhost
send := send.localhost
postqueue := postqueue.localhost

.PHONY: up
up:
	docker compose up -d --build 

.PHONY: down
down:
	docker compose rm -f -s

.PHONY: exec-recv
exec-recv:
	docker compose exec -it $(recv) bash

.PHONY: exec-send
exec-send:
	docker compose exec -it $(send) bash

.PHONY: exec-postqueue
exec-postqueue:
	docker compose exec -it $(postqueue) bash

.PHONY: log-recv
log-recv:
	docker compose logs $(recv)

.PHONY: log-send
log-send:
	docker compose logs $(send)

.PHONY: show-recv-mail
show-recv-mail:
	docker compose exec -it $(recv) cat /var/spool/mail/root

.PHONY: show-send-queue
show-send-queue:
	docker compose exec -it $(send) postqueue -p

.PHONY: send-mail
send-mail:
	sed -e s/TO/$(recv)/ -e s/FROM/$(send)/ mail | docker compose exec -T $(send) sendmail -t

