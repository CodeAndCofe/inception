#!/bin/bash

set -e


# ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
# WP_USER="${MYSQL_USER}"          
# WP_PASSWORD=$(cat /run/secrets/db_password) 


#temporary

ROOT_PASSWORD=ABCBCBC
WP_USER=adil
WP_PASSWORD=AVCD
DB_NAME=wp

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

mysqld --user=mysql --skip-networking &

until mysqladmin ping --silent; do
    sleep 1
done
if [ ! -d "" ]; then
mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';

CREATE DATABASE IF NOT EXISTS ${DB_NAME};

CREATE USER IF NOT EXISTS '${WP_USER}'@'%' IDENTIFIED BY '${WP_PASSWORD}';

GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${WP_USER}'@'%';

FLUSH PRIVILEGES;
EOF
fi
mysqladmin -u root -p"$ROOT_PASSWORD" shutdown

until ! mysqladmin ping --silent; do
    sleep 1
done
exec mysqld --user=mysql