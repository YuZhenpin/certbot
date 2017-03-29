#
#
NAME=certbot
EMAIL=yuzhenpin@huawei.com
DOMAIN=rnd-noproject.huaweiobz.com

all:
	@echo "Makefile targets:"

image:
	docker build -t $(NAME) .

.PHONY: certs
certs: stop-nginx letsencrypt start-nginx

stop-nginx:
	systemctl stop shot-of-tormore.service && docker stop tormore

start-nginx:
	docker start tormore && systemctl start shot-of-tormore.service

letsencrypt:
	docker run --rm \
        -p 443:443 \
        --name $(NAME) \
        -v $(PWD):/etc/letsencrypt \
        -e "email=$(EMAIL)" \
        -e "domains=$(DOMAIN)" \
        $(NAME)



