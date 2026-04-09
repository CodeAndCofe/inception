FROM debian:trixie-backports


WORKDIR /app

COPY ./tools/maria.sh .

RUN apt update -y
RUN apt install mariadb-server mariadb-client galera-4 -y

RUN chmod +x maria.sh
