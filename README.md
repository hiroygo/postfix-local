# postfix-local
Launch the Postfix container environment where mail can be sent and received.

* `make up`: Start containers
* `make send-mail`: Send a test mail from `root@send.localhost` to `root@recv.localhost`
* `make show-recv-mail`: Show mails received by `root@recv.localhost`
* `make log-send`, `make log-recv`: Show send.localhost or recv.localhost logs

## Example
```
% make up
docker compose up -d --build
...

% make send-mail
sed -e s/TO/recv.localhost/ -e s/FROM/send.localhost/ mail | docker compose exec -T send.localhost sendmail -t

% make show-recv-mail
docker compose exec -it recv.localhost cat /var/spool/mail/root
From root@send.localhost  Sat Dec 10 07:37:39 2022
Return-Path: <root@send.localhost>
X-Original-To: root@recv.localhost
Delivered-To: root@recv.localhost
Received: from send.localhost (unknown [172.22.0.2])
        by recv.localhost (Postfix) with ESMTPS id 08B9012EF00
        for <root@recv.localhost>; Sat, 10 Dec 2022 07:37:39 +0000 (UTC)
Received: by send.localhost (Postfix, from userid 0)
        id E3D3F12EEF9; Sat, 10 Dec 2022 07:37:38 +0000 (UTC)
From: root@send.localhost
To: root@recv.localhost
Subject: this is subject
Message-Id: <20221210073738.E3D3F12EEF9@send.localhost>
Date: Sat, 10 Dec 2022 07:37:38 +0000 (UTC)

this is body.

```
