#!/bin/sh

wp core download --locale=fr_FR --allow-root

echo "\nSet right\n"
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

echo "\nGenerates a wp-config.php file"
# wp config create --dbname=	WP_DATABASE_NAME --dbuser=$WP_DATABASE_USR --dbpass=$WP_DATABASE_PWD --dbhost=$MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
wp config create --allow-root --dbname=$MARIADB_DATABASE --dbuser=$WP_ADMIN_USER #--dbpass=$WP_ADMIN_PWD --dbhost=$MARIADB_HOST  --dbcharset="utf8" --dbcollate="utf8_general_ci"  --allow-root

echo "\nInstall WordPress"
wp core install --url=url_example.com --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PWD --admin_email=$ADMIN_EMAIL --dbhost=$MARIADB_HOST  --allow-root
# echo "Success: WordPress installed successfully."

exec php-fpm7.3 -F
# tail -f /dev/null
# /bin/sh