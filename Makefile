DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

up:
	@mkdir -p /home/bberthod/data/mariadb
	@mkdir -p /home/bberthod/data/wordpress
	@printf "\033[32m[+] Starting containers...\033[0m\n"
	docker-compose -f $(DOCKER_COMPOSE_FILE) up --build -d
	@printf "\033[32m[+] Containers started.\033[0m\n"

down:
	@printf "\033[32m[+] Stopping containers...\033[0m\n"
	docker-compose -f $(DOCKER_COMPOSE_FILE) down -v
	@printf "\033[32m[+] Containers stopped.\033[0m\n"

logs:
	@printf "\033[32m[+] Displaying logs...\033[0m\n"
	docker-compose -f $(DOCKER_COMPOSE_FILE) logs -f

restart:
	@printf "\033[32m[+] Restarting containers...\033[0m\n"
	docker-compose -f $(DOCKER_COMPOSE_FILE) restart

kill:
	@printf "\033[32m[+] Killing containers...\033[0m\n"
	docker-compose -f $(DOCKER_COMPOSE_FILE) kill

clean:
	@printf "\033[32m[+] Removing unused volumes...\033[0m\n"
	docker volume prune -f
	@printf "\033[32m[+] Unused volumes removed.\033[0m\n"

rmi:
	@printf "\033[32m[+] Removing Docker images...\033[0m\n"
	@if [ -z "$(shell docker image ls -q)" ]; then \
		printf "\033[33m[+] No Docker images to remove.\033[0m\n"; \
	else \
		docker rmi -f $(shell docker image ls -q); \
	fi
	@printf "\033[32m[+] Docker images removed.\033[0m\n"

.PHONY: up down logs restart kill clean rmi
