#!/bin/bash
set -e

echo "Starting WordPress setup..."

DB_PASS=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_password)

mkdir -p /run/php /var/www/html

cd /var/www/html

for i in $(seq 1 30); do
    if mysqladmin ping -h mariadb -u"$DB_USER" -p"$DB_PASS" --silent 2>/dev/null; then
        break
    fi
    sleep 2
done

if [ ! -f wp-config.php ]; then
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

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --role=subscriber \
         --user_pass="$WP_USER_PASSWORD" \
        --display_name="Regular User" \
        --allow-root
fi


exec php-fpm8.4 -F