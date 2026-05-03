

# docker compose up ::start container
# docker compose down ::stop container

# docker compose down -v ::stop and delete container volumes

# docker compose ps ::checking runing containers



# docker compose restart ::restart services
run:
	docker compose  -f ./srcs/docker-compose.yml up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml down

clean:
	docker compose -f ./srcs/docker-compose.yml down -v

restart:
	docker compose -f ./srcs/docker-compose.yml restart


re: clean run
