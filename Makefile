mda := mda.localhost
mta := mta.localhost

.PHONY: up
up:
	docker compose up -d --build 

.PHONY: stop
stop:
	docker compose rm -f -s

.PHONY: exec-mda
exec-mda:
	docker compose exec -it $(mda) bash

.PHONY: exec-mta
exec-mta:
	docker compose exec -it $(mta) bash

.PHONY: log-mda
log-mda:
	docker compose logs $(mda)

.PHONY: log-mta
log-mta:
	docker compose logs $(mta)

.PHONY: show-mda-mail
show-mda-mail:
	docker compose exec -it $(mda) cat /var/spool/mail/root

.PHONY: show-mta-queue
show-mta-queue:
	docker compose exec -it $(mta) postqueue -p

.PHONY: send-mail
send-mail:
	sed -e s/TO/$(mda)/ -e s/FROM/$(mta)/ mail | docker compose exec -T $(mta) sendmail -t

.PHONY: pipe-test
pipe-test:
	sed -e s/TO/$(mta)/ -e s/FROM/$(mta)/ mail | docker compose exec -T $(mta) sendmail -t
