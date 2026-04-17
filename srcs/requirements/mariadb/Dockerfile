FROM debian:trixie-backports


WORKDIR /app


RUN apt update -y
RUN apt install mariadb-server mariadb-client galera-4 -y

COPY ./tools/maria.sh .
COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/custom.cnf
EXPOSE 3306
RUN chmod +x maria.sh
