FROM alpine:latest
RUN apk update
RUN apk search mariadb
RUN apk add mariadb mariadb-common mariadb-client
EXPOSE 3306
CMD [ "mysqld" ]