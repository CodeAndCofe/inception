#!/bin/bash
set -e

echo "Starting WordPress setup..."

DB_PASS=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_password)

mkdir -p /run/php /var/www/html
chown -R www-data:www-data /run/php /var/www/html

cd /var/www/html

echo "Waiting for MariaDB..."

READY=0
for i in $(seq 1 30); do
    if mysql -h mariadb -u "$DB_USER" -p"$DB_PASS" -e "SELECT 1;" >/dev/null 2>&1; then
        echo "MariaDB is ready!"
        READY=1
        break
    fi
    echo "Waiting... ($i/30)"
    sleep 2
done

if [ "$READY" -eq 0 ]; then
    echo "ERROR: MariaDB not reachable after 30 attempts"
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

    if ! wp user get "$WP_USER" --allow-root >/dev/null 2>&1; then
        wp user create "$WP_USER" "$WP_USER_EMAIL" \
            --role=subscriber \
            --user_pass="$WP_USER_PASSWORD" \
            --display_name="Regular User" \
            --allow-root
    fi
else
    echo "WordPress already installed."
fi

echo "starting php"

exec php-fpm8.4 -F