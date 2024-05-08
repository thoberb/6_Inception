#!/bin/bash

# Wait for 10 seconds to ensure everything is ready
sleep 10

mkdir -p /run/php/
chown www-data:www-data /run/php/
cd /var/www/html

# Check if wp-config.php file exists
if [ -f "/var/www/html/wp-config.php" ]; then
    echo "WordPress is already set up!"
else
    echo "Setting up WordPress"
    sleep 10

    /usr/local/bin/wp-cli.phar core download --allow-root
                                --path='/var/www/html'


    # Create WordPress configuration file
    /usr/local/bin/wp-cli.phar config create --allow-root \
                               --dbname=$SQL_DATABASE \
                               --dbuser=$SQL_USER \
                               --dbpass=$SQL_PASSWORD \
                               --dbhost=$SQL_HOST \
                               --path='/var/www/html'

    
    # Set appropriate permissions for wp-config.php file
    chmod 777 /var/www/html/wp-config.php

    # Install WordPress
    /usr/local/bin/wp-cli.phar core install --allow-root \
                               --url=$DOMAIN_NAME \
                               --title="$TITLE" \
                               --admin_user=$WP_ADMIN_USER \
                               --admin_password=$WP_PASSWORD \
                               --admin_email=$WP_ADMIN_MAIL \
                               --path='/var/www/html'

    # Create an additional user
    /usr/local/bin/wp-cli.phar user create $WP_SECOND_USER $WP_SECOND_USER_MAIL \
                             --allow-root \
                             --role=author \
                             --user_pass=$WP_SECOND_USER_PW \
                             --path='/var/www/html'

    chown -R root:root /var/www/html
    
    echo "WordPress is running!"

fi
# Start PHP-FPM
exec /usr/sbin/php-fpm7.4 -F -R