#!/bin/bash
set -e

echo "Starting MariaDB setup..."

ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_PASSWORD=$(cat /run/secrets/db_password)

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

mysqld --user=mysql --bind-address=0.0.0.0 --port=3306 &

until mysqladmin ping -h 127.0.0.1 --silent; do
    sleep 1
done

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
    echo "Initializing database..."

    mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    echo "Database initialized."
else
    echo "Database already exists."
fi

# Stop temporary server
mysqladmin -u root -p"${ROOT_PASSWORD}" shutdown

# Start real server (network enabled)
echo "Starting MariaDB in foreground..."
exec mysqld --user=mysql --bind-address=0.0.0.0 --port=3306