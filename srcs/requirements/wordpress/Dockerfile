FROM debian:buster

RUN apt update \
    && apt upgrade \
    && apt install curl -y \
    && apt install php-gd php-mbstring php-fpm php-xml php-xmlrpc php-soap php-intl php-zip -y

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# do equivalent of the script in the container
RUN mkdir -p /var/www/html
COPY ./cli/docker-entrypoint.sh /usr/local/bin
COPY ./conf/php-fpm.conf /etc/php 

EXPOSE 9000
ENTRYPOINT ["cat"]
#ENTRYPOINT [ "docker-entrypoint.sh" ]