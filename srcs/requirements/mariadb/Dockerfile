# Use Debian Bullseye as the base image
FROM debian:bullseye

# Update and install MariaDB and other dependencies
RUN apt-get update -y && \
    apt-get install -y mariadb-server mariadb-client procps

 # Copy the provided config file to the container
 COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf

# Create necessary directories and set permissions
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 755 /var/run/mysqld

RUN mkdir -p /var/lib/mysql && \
    chown mysql:mysql /var/lib/mysql && \
    chmod 755 /var/lib/mysql

# Expose MariaDB port
EXPOSE 3306

# Copy setup script
COPY ./tools/mdbscript.sh /usr/local/bin/mdbscript.sh
RUN chmod +x /usr/local/bin/mdbscript.sh

# Set the entry point to the setup script
ENTRYPOINT ["/usr/local/bin/mdbscript.sh"]