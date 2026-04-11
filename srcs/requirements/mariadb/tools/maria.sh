#!/bin/bash
set -e

set -a

source .env

set +a

ROOT_PASSWORD=$(cat ./secrets/db_root_password)
WP_DATABASE="${MYSQL_DATABASE}"
WP_USER="${MYSQL_USER}"
WP_PASSWORD=$(cat ./secrets/db_password)

if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

if mariadb -u root -e "USE $WP_DATABASE;" 2>/dev/null; then
    echo "WordPress database already exists. Skipping setup."
else
    echo "Setting up MariaDB for WordPress..."

    mysqld --skip-networking --user=mysql &
    
    while ! mysqladmin ping --silent; do
        sleep 1
    done
    
    mysqladmin -u root password "$ROOT_PASSWORD"
    
    mysql -u root -p"$ROOT_PASSWORD" <<EOF
        CREATE DATABASE IF NOT EXISTS $WP_DATABASE;
        CREATE USER IF NOT EXISTS '$WP_USER'@'%' IDENTIFIED BY '$WP_PASSWORD';
        GRANT ALL PRIVILEGES ON $WP_DATABASE.* TO '$WP_USER'@'%';
        FLUSH PRIVILEGES;
    EOF
    
    mysqladmin -u root -p"$ROOT_PASSWORD" shutdown
    
    # Wait for shutdown to complete
    while mysqladmin ping --silent; do
        sleep 1
    done
    
    echo "MariaDB setup complete."
fi

# Start MariaDB as main process
exec mysqld --user=mysql