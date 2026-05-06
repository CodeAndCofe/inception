#!/bin/bash
set -e

echo "Starting MariaDB setup..."

ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_PASSWORD=$(cat /run/secrets/db_password)


mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

if [ ! -f "/var/lib/mysql/.initialized" ]; then
    echo "Initializing database (offline)..."

    mariadb-install-db --user=mysql --datadir=/var/lib/mysql >/dev/null
    mariadbd --bootstrap --user=mysql <<EOF
USE mysql;
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    touch /var/lib/mysql/.initialized
fi

echo "Starting MariaDB in foreground..."

exec mariadbd --user=mysql --bind-address=0.0.0.0 --port=3306 --socket=/run/mysqld/mysqld.sock
