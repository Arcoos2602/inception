FROM alpine:latest

WORKDIR /var/www/wordpress
RUN     apk update && apk upgrade && apk add --update --no-cache \
            php8 \
            php8-fpm \
            php8-opcache \
            php8-mysqli \
            php8-phar \
            php8-iconv \
            mysql-client \
            shadow \
            curl \
            openrc \
 &&     rm -f /var/cache/apk/*

RUN useradd www-data -g www-data \
 &&     mkdir -p /home/www-data \
 &&     chown -R www-data:www-data /home/www-data /var/www/wordpress
COPY    conf/php-fpm.conf   /etc/php8/
COPY    conf/www.conf   /etc/php8/php-fpm.d/
COPY ./cli/docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
# USE WORKDIR THIS IS UGLY
#USER www-data
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
EXPOSE 9000
