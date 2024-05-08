# Allow to tell docker under which OS my virtual machine is running
FROM debian:bullseye

# Install NGINX and other dependencies
RUN apt-get update -y
RUN apt-get install -y nginx
RUN apt-get install -y vim
RUN apt-get install -y curl
RUN apt-get install -y openssl

RUN mkdir -p /etc/nginx/ssl

# Use OPENSSL to generate a self-signed SSL certificate
# for the NGINX server, enabling secure HTTPS connections
RUN    openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
       -out /etc/ssl/certs/certificate.crt \
       -keyout /etc/ssl/private/certificate.key \
       -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=bberthod.42.fr/UID=bberthod"

# Configure the NGINX environnement in a Docker container's
COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/run/nginx
RUN mkdir -p /var/www/html
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# The Docker container's is listening on this port
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
