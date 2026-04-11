FROM debian:trixie-backports


WORKDIR /app


RUN apt update -y
RUN apt install mariadb-server mariadb-client galera-4 -y

COPY ./tools/maria.sh .

RUN chmod +x maria.sh
