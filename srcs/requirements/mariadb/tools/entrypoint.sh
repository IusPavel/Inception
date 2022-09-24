#!/bin/bash

if [ ! -e /var/lib/mysql/$MARIADB_DATABASE ]; then
	cat << EOF > script.tmp
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
CREATE DATABASE $MARIADB_DATABASE;
CREATE USER '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%';
FLUSH PRIVILEGES;
EOF
	mariadbd -umysql --bootstrap < script.tmp
	rm -f script.tmp
fi

if [ "$1" = 'mariadbd' ] || [ "$1" = 'mysqld' ]; then
	exec gosu mysql "$@"
fi
exec "$@"