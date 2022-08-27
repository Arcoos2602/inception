COMPOSE_FILE=./srcs/docker-compose.yml

all: run

run:
	@sudo mkdir -p /home/${USER}/data/wordpress
	@sudo mkdir -p /home/${USER}/data/mysql
	@docker-compose -f $(COMPOSE_FILE) up --build

up:
	@sudo mkdir -p /home/${USER}/data/wordpress
	@sudo mkdir -p /home/${USER}/data/mysql
	@docker-compose -f $(COMPOSE_FILE) up -d --build

debug:
	@sudo mkdir -p /home/${USER}/data/wordpress
	@sudo mkdir -p /home/${USER}/data/mysql
	@docker-compose -f $(COMPOSE_FILE) --verbose up

clean: 	
	@docker-compose -f $(COMPOSE_FILE) down
	@-docker stop `docker ps -qa`
	@-docker rm `docker ps -qa`
	@-docker rmi -f `docker images -qa`
	@-docker volume rm `docker volume ls -q`
	@sudo rm -rf /home/${USER}/data/wordpress
	@sudo rm -rf /home/${USER}/data/mysql

.PHONY: run up debug list list_volumes clean