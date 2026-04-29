
WP_USER="adil"
DB_USER="adil"
DB_PASS="pass"
DB_NAME="wp"
DB_HOST="mariadb"
WP_URL=https://aferryat.42.ft.com
WP_TITLE=Blog
WP_ADMIN_USER=aferryat
WP_ADMIN_PASSWORD=33333333
WP_ADMIN_EMAIL=adilprogrammer@gmail.com

cd /var/www/html

$(WP) core download

if [! -f wp-config.php] then;

wp config create \
  --dbname=$(DB_NAME) \
  --dbuser=$(DB_USER) \
  --dbpass=$(DB_PASS) \
  --dbhost=$(mariadb)

wp core install \
  --url=$(WP_URL) \
  --title=$(WP_TITLE)\
  --admin_user=$(WP_ADMIN_USER) \
  --admin_password=$(WP_ADMIN_PASSWORD) \
  --admin_email=$(WP_ADMIN_EMAIL)

fi