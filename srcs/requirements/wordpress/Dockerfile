FROM debian:bullseye

# Update and upgrade packages
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y wget
RUN apt-get install -y php7.4 php-fpm php-mysql default-mysql-client mariadb-client
RUN apt-get clean

# Empty cache
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html

# Download and extract Wordpress
RUN wget https://wordpress.org/wordpress-6.2.2.tar.gz -P /var/www \
    && cd /var/www \
    && tar -xzf wordpress-6.2.2.tar.gz \
    && rm wordpress-6.2.2.tar.gz \
    && cp -r /var/www/wordpress/. /var/www/html/

# Install WP-CLI (handling wordpress cmd)
RUN cd /var/www/html \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp-cli.phar

# Set permissions and ownership for web server
RUN chown -R www-data:www-data /var/www/* && \
    chmod -R 755 /var/www/*

# Expose PHP-FPM port for communicate between NGINX and PHP
EXPOSE 9000

# Copy PHP-FPM pool configuration
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Entry point script
COPY ./tools/wpscript.sh /bin/wpscript.sh
RUN chmod 777 /bin/wpscript.sh

ENTRYPOINT ["bash", "/bin/wpscript.sh"]