FROM debian:stable

RUN apt-get update && apt-get install -y nginx
RUN apt-get update && apt-get install -y openssl
RUN mkdir -p /ssl
RUN openssl genpkey -algorithm RSA -out /ssl/private.key
RUN openssl req -new -x509 -days 365 -key /ssl/private.key -out /ssl/certificate.pem \
 -subj "/C=MA/ST=State/L=None/O=None/CN=None"

COPY conf /etc/nginx/nginx.conf
COPY tools/launch.sh /launch.sh
RUN chmod +x launch.sh

CMD ["./launch.sh"]
