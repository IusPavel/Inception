FROM	debian:buster

RUN		set -e; apt-get update; apt-get install -y \
			nginx \
			openssl; \
		ln -sf /dev/stdout /var/log/nginx/access.log; \
		ln -sf /dev/stderr /var/log/nginx/error.log; \
		openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/test-cert.key -out /etc/ssl/certs/test-cert.crt -subj "/C=RU/ST=TATARSTAN/L=KAZAN/O=School21/CN=test-site"

COPY	conf /etc/nginx/conf.d

EXPOSE	443
CMD		["nginx", "-g", "daemon off;"]