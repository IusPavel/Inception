FROM		debian:buster

#Test container
#ENV MARIADB_DATABASE=db_wordpress
#ENV MARIADB_ROOT_PASSWORD=1234
#ENV MARIADB_USER=signacia
#ENV MARIADB_PASSWORD=123

RUN 		groupadd -r mysql; useradd -r -g mysql mysql; \
			set -e; apt-get update; apt-get install -y \
				apt-transport-https \
				curl \
				gosu; \
			curl -o /etc/apt/trusted.gpg.d/mariadb_release_signing_key.asc 'https://mariadb.org/mariadb_release_signing_key.asc'; \
			echo 'deb https://mirror.docker.ru/mariadb/repo/10.8/debian buster main' >> /etc/apt/sources.list; \
			apt-get update && apt-get install -y \
				mariadb-server; \
	 		mkdir -p /var/lib/mysql /var/run/mysqld; \
			chown -R mysql:mysql /var/lib/mysql /var/run/mysqld; \
			chmod 777 /var/run/mysqld; \
			rm -rf /var/lib/apt/lists/*

COPY		conf/mariadb.cnf /etc/mysql/mariadb.cnf
COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY		tools/entrypoint.sh /

EXPOSE		3306
VOLUME		/var/lib/mysql
ENTRYPOINT	[ "bash", "entrypoint.sh" ]
CMD			[ "mariadbd" ]