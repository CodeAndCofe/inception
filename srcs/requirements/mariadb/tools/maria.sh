#!/bin/bash
set -e

echo "Starting MariaDB setup..."

ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
WP_PASSWORD=$(cat /run/secrets/db_password)

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

mysqld --user=mysql --skip-networking &

MYSQL_PID=$!

until mysqladmin ping --silent; do
    sleep 1
done

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."

    mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';

CREATE DATABASE IF NOT EXISTS ${DB_NAME};

CREATE USER IF NOT EXISTS '${WP_USER}'@'%' IDENTIFIED BY '${WP_PASSWORD}';

GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${WP_USER}'@'%';

FLUSH PRIVILEGES;
EOF

    echo "Database initialized."
else
    echo "Database already exists. Skipping init."
fi

mysqladmin -u root -p"${ROOT_PASSWORD}" shutdown


echo "Starting MariaDB in foreground..."

exec mysqld --user=mysql