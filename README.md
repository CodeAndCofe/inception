This project has been created as part of the 42 curriculum by aferryat.

## DESCRIPTION

This project consists of building a small infrastructure using Docker. The goal is to deploy a working web environment composed of multiple services that communicate with each other in a secure and isolated way.

The stack typically includes a web server, a database server, and a web application. Each service runs inside its own container to ensure separation of concerns and reproducibility across different environments.

The main objective of this project is to understand how containerization works, how services interact through networks, and how persistent data is managed using Docker volumes or bind mounts.

## INSTRUCTIONS

	To run the project, you must have Docker and Docker Compose installed on your system.

	# Build images
	docker compose build

	# Start services (foreground)
	docker compose up

	# Start services (background)
	docker compose up -d

	# Stop and remove containers + network
	docker compose down

	# Stop and remove containers + network + volumes (⚠️ deletes DB data)
	docker compose down -v

	# Rebuild and start (use after Dockerfile/compose changes)
	docker compose up --build

	Persistent data such as the database is stored on the host machine to ensure it is not lost when containers are removed.

## PROJECT DESCRIPTION

	This project is built using Docker to simulate a real-world server infrastructure. Each service runs inside a container, which isolates it from the host system and other services.

	Docker was chosen instead of virtual machines because it is lighter, faster, and more efficient in terms of resource usage. Containers share the host operating system kernel, while virtual machines run a full operating system for each instance.

	Virtual Machines vs Docker
	Virtual machines emulate complete operating systems, making them heavy and slower to start. Docker containers are lightweight and share the host system kernel, which makes them faster and easier to scale.

	Secrets vs Environment Variables
	Environment variables are used in this project to pass configuration such as database credentials. Secrets provide better security in production environments, but environment variables are simpler and commonly used in educational projects.

	Docker Network vs Host Network
	Docker networking allows containers to communicate with each other in an isolated environment. This is safer than host networking, which exposes services directly on the host machine.

	Docker Volumes vs Bind Mounts
	Volumes are managed by Docker and are more portable, while bind mounts link a directory from the host machine directly into a container. Bind mounts are used here to allow direct access to persistent data such as database files.

## RESOURCES
	https://www.geeksforgeeks.org/devops/introduction-to-docker/
	Docker official documentation
	MariaDB official documentation
	Nginx documentation