#!/bin/bash
set -e

echo "Starting MariaDB setup..."

ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_PASSWORD=$(cat /run/secrets/db_password)

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# Start MariaDB temporarily for init (no networking, background)
mysqld_safe --skip-networking &
MYSQL_PID=$!

# Wait until socket is ready
until mysqladmin ping --socket=/run/mysqld/mysqld.sock --silent 2>/dev/null; do
    echo "Waiting for MariaDB socket..."
    sleep 1
done

# Use a flag file inside the data dir, not the DB directory itself
if [ ! -f "/var/lib/mysql/.initialized" ]; then
    echo "Initializing database..."
    mysql --socket=/run/mysqld/mysqld.sock -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
    touch /var/lib/mysql/.initialized
    echo "Database initialized."
else
    echo "Database already initialized, skipping."
fi

# Cleanly shut down the temporary instance
mysqladmin --socket=/run/mysqld/mysqld.sock -u root -p"${ROOT_PASSWORD}" shutdown
wait $MYSQL_PID

echo "Starting MariaDB in foreground..."
exec mysqld_safe --bind-address=0.0.0.0 --port=3306