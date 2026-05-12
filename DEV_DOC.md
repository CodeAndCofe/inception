This project has been created as part of the 42 curriculum by aferryat.

## DEVELOPMENT ENVIRONMENT SETUP

    To set up the project from scratch, Docker and Docker Compose must be installed.

    Verify installation:

    docker --version
    docker compose version

    BUILDING THE PROJECT

    To build all services:

    docker compose build

    To rebuild without cache:

    docker compose build --no-cache

    RUNNING THE PROJECT

    Start all services:

    docker compose up

    Start in detached mode:

    docker compose up -d

    Stop all services:

    docker compose down

    Remove containers and networks:

    docker compose down --volumes

### PROJECT STRUCTURE

    The project is organized into multiple services defined in a docker compose file. Each service has its own Dockerfile and configuration.

##### Main components:

    web server container
    database container
    application container
    DATA STORAGE

Persistent data is stored using either Docker volumes or bind mounts.

#### Bind mounts are used for:

database files
configuration persistence

#### Example path:

/home/aferryat/data/mariadb

This ensures that data remains available even if containers are removed.

USEFUL COMMANDS

View running containers:

docker ps

#### View logs:

docker compose logs -f

Access a container shell:

docker exec -it <container_name> bash

#### Inspect networks:

docker network ls

#### Inspect volumes:

docker volume ls

### NOTES ON DESIGN

Each service is isolated in its own container to ensure modularity and easy maintenance. Communication between services is handled through Docker networks instead of exposing all ports publicly.

Environment variables are used for configuration, making the system flexible and easy to modify without changing code.