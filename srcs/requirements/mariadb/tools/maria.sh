# #!/bin/bash
set -e

echo "Starting MariaDB setup..."

ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_PASSWORD=$(cat /run/secrets/db_password)

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# mysqld --user=mysql

# sleep 5


if [ ! -f "/var/lib/mysql/.initialized" ]; then
    echo "Initializing database..."
    echo "starting mariadb"
    mysqld  -u root  <<EOF
USE mysql;
FLUSH PRIVILEGES;
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
    touch /var/lib/mysql/.initialized
    echo "Database initialized."
else
    echo "Database already initialized, skipping."
fi

# mysqladmin -u root -p"${ROOT_PASSWORD}" shutdown

echo "Starting MariaDB in foreground..."

exec mysqld --user=mysql --bind-address=0.0.0.0 --port=3306



check the admin and check sql 

!/bin/sh

