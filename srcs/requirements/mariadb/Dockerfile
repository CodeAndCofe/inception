FROM debian:trixie-backports

WORKDIR /app

RUN apt-get update -y && \
    apt-get install -y mariadb-server mariadb-client \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3306

COPY ./tools/maria.sh /app/script.sh

RUN chmod +x /app/script.sh

ENTRYPOINT ["/app/script.sh"]