This project has been created as part of the 42 curriculum by aferryat.

## OVERVIEW

    This project provides a small web infrastructure made of multiple services running inside Docker containers. The system includes a web server, a database, and a web application.

    The goal is to provide a working environment that can be started easily and accessed through a browser.

## STARTING THE PROJECT

    To start the services, run:

    docker compose up

    To run in the background:

    docker compose up -d

    To stop the project:

    docker compose down

    ACCESSING THE SERVICES

    Once the project is running, the website can be accessed through:

    http://localhost

    If a specific domain is configured in the project, it should be used instead of localhost.

    The database service is not directly exposed to the browser but is accessible internally by the application.

## CREDENTIALS MANAGEMENT

    Database credentials are stored in environment variables defined in the configuration files. These include:

    database name
    database user
    database password
    root password

    These values are required for proper initialization of the database service.

    CHECKING SERVICE STATUS

    To verify that containers are running:

    docker ps

    To view logs:

    docker compose logs

    Each service runs in its own container, and logs can be used to debug issues or confirm correct startup.

## DATA PERSISTENCE

    Database data is stored on the host machine using a mounted directory or volume. This ensures that data is not lost when containers are stopped or removed.