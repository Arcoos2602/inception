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
 &&     rm -f /var/cache/apk/*

COPY ./cli/docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
# USE WORKDIR THIS IS UGLY
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
EXPOSE 9000
