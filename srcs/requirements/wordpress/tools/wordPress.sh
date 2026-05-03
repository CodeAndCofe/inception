#!/bin/bash
set -e

echo "Starting WordPress setup..."

DB_PASS=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_password)

cd /var/www/html

echo "Waiting for MariaDB..."

for i in $(seq 1 30); do
    if mysqladmin ping -h mariadb -u"$DB_USER" -p"$DB_PASS" --silent 2>/dev/null; then
        echo "MariaDB is ready!"
        break
    fi
    echo "Waiting... ($i/30)"
    sleep 2
done

if [ "$i" -eq 30 ]; then
    echo "ERROR: MariaDB not reachable"
    exit 1
fi

if [ ! -f wp-config.php ]; then
    echo "Installing WordPress..."

    wp core download --allow-root

    wp config create \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASS" \
        --dbhost=mariadb \
        --allow-root

    wp core install \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root
    chown -R  www-data:www-data /var/www/html
fi

echo "Starting PHP-FPM..."

exec php-fpm8.4 -F