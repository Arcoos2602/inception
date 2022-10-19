#!/bin/sh

echo "\nSet right\n"
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

echo "\nGenerates a wp-config.php file"
# wp config create --dbname=	WP_DATABASE_NAME --dbuser=$WP_DATABASE_USR --dbpass=$WP_DATABASE_PWD --dbhost=$MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
wp config create --dbname=$MARIADB_DATABASE --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_SITE_TITLE  --dbcharset="utf8" --dbcollate="utf8_general_ci"  --allow-root

echo "\nInstall WordPress"
wp core install --url=url_example.com --title=$WORDPRESS_SITE_TITLE --admin_user=$WORDPRESS_DB_USER --admin_password=$WORDPRESS_DB_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --dbhost=$MARIADB_HOST  --allow-root
echo "Success: WordPress installed successfully."

exec php-fpm7.3 -F
# tail -f /dev/null
# /bin/sh