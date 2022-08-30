#!/bin/sh

# script to set up wordpress
# have to update .env accordingly
# download wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

# download wp files
./wp-cli.phar core download

# configure wp
echo "installation valid"

./wp-cli.phar config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST \
    #--dbprefix=$WP_TABLE_PREFIX \
    #--dbcharset=$WP_DB_CHARSET \
    #--dbcollate=$WP_DB_COLLATE

# create wordpress database
./wp-cli.phar db create

# install wordpress
./wp-cli.phar core install  --url=$WORDPRESS_SITE_URL --title=$WORDPRESS_SITE_TITLE --admin_user=$WORDPRESS_DB_USER --admin_password=$WORDPRESS_DB_PASSWORD --admin_email==$WORDPRESS_ADMIN_EMAIL --skip-email
    #--title=$WP_SITE_TITLE \
    #-admin_user=$WP_DB_ADM_USER \

# non root user
#eval "echo \"$(cat /tmp/mysql/wp_db_user.sql)\"" > /tmp/mysql/import.sql
#mysql -h mariadb -u $WP_DB_ADM_USER --password=$WP_DB_ADM_PASSWORD < "/tmp/mysql/import.sql"
#rm -rf /tmp/mysql/wp_db_user.sql /tmp/mysql/import.sql

# add a theme
./wp-cli.phar theme install twentytwenty --activate

# launch php-fpm
php-fpm8