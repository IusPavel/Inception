#!/bin/bash

if [ ! -e /var/www/html/wp-config.php ]; then
	gosu www-data wp config create \
		--dbname=${WORDPRESS_DB_NAME} \
		--dbuser=${WORDPRESS_DB_USER} \
		--dbpass=${WORDPRESS_DB_PASSWORD} \
		--dbhost=${WORDPRESS_DB_HOST} \
		--path=/var/www/html/ \
		--skip-check
	
	sleep 3 # Because of network NOT established
	gosu www-data wp core install \
		--url=localhost \
		--title=inception \
		--admin_user=${WORDPRESS_ADMIN_USER} \
		--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
		--admin_email=${WORDPRESS_ADMIN_USER}@example.com \
		--skip-email \
		--path=/var/www/html/
	gosu www-data wp user create \
		${WORDPRESS_USER} \
		${WORDPRESS_USER}@example.com \
		--role=author \
		--user_pass=${WORDPRESS_USER_PASSWORD} \
		--path=/var/www/html/
fi

exec "$@"
	