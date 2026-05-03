#!/bin/bash

set -e

echo "Starting MariaDB setup..."

ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_PASSWORD=$(cat /run/secrets/db_password)

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

service mariadb start

until mysqladmin ping -h 127.0.0.1 --silent; do
    echo "connecting ..."
    sleep 1
done

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
    echo "Initializing database..."
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
    echo "Database initialized."
else
    echo "Database already exists."
fi

mysqladmin -u root -p"${ROOT_PASSWORD}" shutdown

echo "Starting MariaDB in foreground..."
exec mysqld_safe