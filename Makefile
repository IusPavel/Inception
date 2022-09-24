VOLUME_PATH		=	$(PWD)/data
WORDPRESS_PATH	=	$(VOLUME_PATH)/wordpress
MARIADB_PATH	=	$(VOLUME_PATH)/dbdata

.PHONY:	all clean fclean re

all:
		@mkdir -p $(WORDPRESS_PATH)
		@mkdir -p $(MARIADB_PATH)
		@cd srcs && docker-compose build && docker-compose up -d

clean:
		@cd srcs && docker-compose down

fclean:	clean
		-@docker rmi srcs_mariadb srcs_wordpress srcs_nginx srcs_adminer
		-@docker volume rm srcs_dbdata srcs_wordpress
		#uncomment next line to remove data
		#-@sudo rm -rf $(VOLUME_PATH)

re:		clean all