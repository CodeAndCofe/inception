FROM debian:trixie-slim

WORKDIR /app

RUN apt-get update -y && \
    apt-get install -y mariadb-server mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
# RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

EXPOSE 3306

COPY ./tools/maria.sh /app/script.sh

RUN chmod +x /app/script.sh

ENTRYPOINT ["/app/script.sh"]