
run:
	@mkdir -p /home/aferryat/data/wordpress
	@mkdir -p /home/aferryat/data/mariadb
	@docker compose  -f ./srcs/docker-compose.yml up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml down

clean:
	docker compose -f ./srcs/docker-compose.yml down -v

fclean: clean
	@sudo rm -rf /home/aferryat/data/*

restart:
	docker compose -f ./srcs/docker-compose.yml restart

logs:
	docker compose -f ./srcs/docker-compose.yml logs

re: clean run
