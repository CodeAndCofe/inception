#!/bin/bash

set -e

echo "WordPress container starting..."
ROOT_PASSWORD=$(cat ./secrets/db_root_password.txt)
DB_DATABASE="${MYSQL_DATABASE}"
DB_USER="${MYSQL_USER}"
DB_PASSWORD=$(cat ./secrets/db_password.txt)
touch   wp-config.php

cat > /var/www/html/wp-config.php <<EOF
<?php
    define('DB_NAME', $DB_DATABASE);
    define('DB_USER', $DB_USER);
    define('DB_PASSWORD', $ROOT_PASSWORD);
    define('DB_HOST', 'localhost:3306');
?>
EOF
exec php-fpm8.2 -F