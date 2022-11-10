# postfix-local
Start Postfix containers as MTA and MDA for send test mail.

* `make up`: Start containers
* `make send-mail`: Send a test mail from MTA to MDA
* `make show-mda-mail`: Show mails received by MDA
* `make log-mta`, `make log-mda`: Show MTA or MDA logs

## Example
```
% make up
docker compose up -d --build
...

% make send-mail 
sed s/FQDN/mda.localhost/g mail | docker compose exec -T mta.localhost sendmail -t

% make show-mda-mail
docker compose exec -it mda.localhost cat /var/spool/mail/root
From root@mta.localhost  Thu Nov 10 15:36:43 2022
Return-Path: <root@mta.localhost>
X-Original-To: root@mda.localhost
Delivered-To: root@mda.localhost
Received: from mta.localhost (unknown [172.22.0.3])
	by mda.localhost (Postfix) with ESMTPS id 42282F9461
	for <root@mda.localhost>; Thu, 10 Nov 2022 15:36:43 +0000 (UTC)
Received: by mta.localhost (Postfix, from userid 0)
	id 34955F9457; Thu, 10 Nov 2022 15:36:43 +0000 (UTC)
From: root@mda.localhost
To: root@mda.localhost
Subject: this is subject
Message-Id: <20221110153643.34955F9457@mta.localhost>
Date: Thu, 10 Nov 2022 15:36:43 +0000 (UTC)

this is body.

```
