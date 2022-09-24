FROM		debian:buster

RUN			set -e; apt-get update; apt-get install -y \
				apt-transport-https \
				ca-certificates \
				curl \
				gosu \
				lsb-release; \
			# PHP+FPM modules block
			curl --silent -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg; \
			echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list; \
			apt-get update; apt-get install -y \
				php7.4 \
				php7.4-fpm \
				php7.4-mysql; \
			# Wordpress block
			curl --silent -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
			chmod +x wp-cli.phar; \
			mv wp-cli.phar /usr/local/bin/wp; \
			mkdir -p /var/www/html /var/www/.wp-cli; \
			chown -R www-data:www-data /var/www/html /var/www/.wp-cli; \
			gosu www-data wp core download --path=/var/www/html/; \
			rm -rf /var/lib/apt/lists/*

COPY		tools/entrypoint.sh		/
COPY		conf/php-fpm.conf		/etc/php/7.4/fpm/php-fpm.conf
COPY		conf/www.conf			/etc/php/7.4/fpm/pool.d/www.conf

WORKDIR 	/var/www/html
STOPSIGNAL	SIGQUIT
EXPOSE		9000
ENTRYPOINT	[ "/bin/bash", "/entrypoint.sh" ]
CMD 		[ "/usr/sbin/php-fpm7.4" ]