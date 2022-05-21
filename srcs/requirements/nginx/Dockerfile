FROM alpine:latest
# install prerequisites
RUN apk update
RUN apk add openssl curl ca-certificates
RUN  apk --no-cache add curl
# install packages for stable nginx
RUN printf "%s%s%s%s\n" \
    "@nginx " \
    "http://nginx.org/packages/alpine/v" \
    `egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
    "/main" \
    | tee -a /etc/apk/repositories
# import official nginx signing key
RUN curl -o /tmp/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub
# verify downloaded file contains proper key
RUN openssl rsa -pubin -in /tmp/nginx_signing.rsa.pub -text -noout
# move key to apk trusted key storage
RUN mv /tmp/nginx_signing.rsa.pub /etc/apk/keys/
# install nginx
RUN apk add nginx@nginx
# needs to copy config files
RUN mkdir /data/
RUN mkdir /data/www
RUN mkdir /data/images
COPY conf/nginx.conf /usr/local/etc/nginx/
COPY conf/index.html /data/www/
COPY conf/test.jpg /data/images/
# nginx .pid
RUN nginx -c /usr/local/etc/nginx/nginx.conf # -c stands configuration file.
RUN nginx
EXPOSE 443/tcp