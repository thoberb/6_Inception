#!/bin/bash

# infile modification of the queries file to replace the placeholders with the expanded values
sed -i "s/\:DB_NAME/${DB_NAME}/g" /mariadb-conf.d/init.sql
sed -i "s/\:USER/${DB_USER}/g" /mariadb-conf.d/init.sql
sed -i "s/\:UPASS/${USER_PASSWORD}/g" /mariadb-conf.d/init.sql
sed -i "s/\:ADMIN/${ADMIN}/g" /mariadb-conf.d/init.sql
sed -i "s/\:APASS/${ADMIN_PASSWORD}/g" /mariadb-conf.d/init.sql

# create directories that will be used by mariadb to store runtime files like the file containing the pid of the running instance
if [ ! -d /var/run/mysqld ]; then
 mkdir /var/run/mysqld
fi
if [ ! -d /run/mysqld ]; then
 mkdir /run/mysqld
fi

if [ ! -d /var/lib/mysql/mysql ]; then
 mysql_install_db --user=root
fi
# NOTE: will have to run the daemon in the foreground to keep the container up
# thus we have to: start the mariadb service in the background, execute the queries, kill the background service then start mariadb in the foreground
service mariadb start
# Loop for checking if the mariadb server is up or not
while ! mysqladmin ping -hlocalhost --silent 2>/dev/null; do
 sleep 1
done
mysql -u root < /mariadb-conf.d/init.sql
service mariadb stop
while  mysqladmin ping -hlocalhost --silent 2>/dev/null; do
 sleep 1
done
# run the service in the foreground
exec mysqld -u root
