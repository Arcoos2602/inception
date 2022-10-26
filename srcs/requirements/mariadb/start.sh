#!/bin/sh

if [ ! -d $DATADIR/mysql ]; then #check if database is not already created
	echo "\n[i]Initialization of database\n"
	mysql_install_db --datadir=$DATADIR   > /dev/null

	# starting my_sqld with mysqld_safe ( for safety )
	mysqld_safe &

	sleep 2

	echo "\n[i] Delete useless stuff\n[i] Set password for root\n[i] Create database\n[i] Create user\n"
	#connect as root without password then set password at root 
	mysql -u  root  --skip-password <<- EOF 
		USE mysql;
		FLUSH PRIVILEGES;
		DELETE FROM	mysql.user WHERE User='';
		DROP DATABASE test;
		DELETE FROM mysql.db WHERE Db='test';
		DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
		
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';

		CREATE DATABASE  IF NOT EXISTS $MARIADB_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
		CREATE USER  IF NOT EXISTS '$WP_ADMIN_USER'@'%' IDENTIFIED by '$WP_ADMIN_PWD';
		GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$WP_ADMIN_USER'@'%';
		FLUSH PRIVILEGES;
	EOF
	sleep 2
	echo "[i] Insert back up databases '$MARIADB_DATABASE'"
	mysql -u root -p"$ROOT_PASSWORD" wordpress < ./dump.sql # to have database
	sleep 2
	#echo "[i] Shut down the server with mysqladmin"
	mysqladmin -uroot -p"$ROOT_PASSWORD" shutdown

	echo "[i] database restarting\n"
	sleep 2
else
	echo "\n[i] Skipping initializatio cause Mysql database is already created"
fi

# starting as root is ugly
echo "[i] Starting mariadb server\n"
exec mysqld -u root