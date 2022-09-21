# Inception
First meeting with Docker.
The goal of this project is to set up a small infrastructure composed of different services under specific rules:
* Write own Dockerfiles, one per service;
* Dockerfiles is called in docker-compose.yml by Makefile.

The services are Nginx with TLS, Wordpress + php-fpm, MariaDB. See full rules in subject, Chapter 4.


How it works:
1. Run `make` in root of project.
2. Open https://localhost in your browser.
