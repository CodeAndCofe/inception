FROM debian:trixie-slim

WORKDIR /app

RUN apt-get update -y && \
    apt-get install -y mariadb-server mariadb-client

EXPOSE 3306

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/custom.cnf
COPY    ./tools/maria.sh /app/script.sh

RUN chmod +x /app/script.sh


ENTRYPOINT [ "/app/script.sh" ]