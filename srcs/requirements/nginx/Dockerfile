FROM alpine:latest
# install prerequisites
RUN apk update \
    apk install \
    && apk add openssl curl ca-certificates \
    && apk add nginx \
    && apk --no-cache add curl
# install packages for stable nginx
RUN printf "%s%s%s%s\n" \
    "@nginx " \
    "http://nginx.org/packages/alpine/v" \
    `egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
    "/main" \
    | tee -a /etc/apk/repositories
RUN mkdir /etc/nginx/certificates && \
	    openssl req \
		    -x509 \
		    -newkey rsa:2048 \
		    -keyout /etc/nginx/certificates/tcordonn.key \
		    -days 365 \
		    -out /etc/nginx/certificates/tcordonn.cert \
		    -nodes \
		    -subj /CN=tcordonn.42.fr
# DEPRECATED KEY
#RUN curl -o /tmp/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub
#RUN openssl rsa -pubin -in /tmp/nginx_signing.rsa.pub -text -noout
#RUN mv /tmp/nginx_signing.rsa.pub /etc/apk/keys/
# copy config file
COPY ./conf/nginx.conf /etc/nginx/
# CMD RUNNED BY ROOT NOT SECURE PID 1
CMD ["nginx", "-g","daemon off;"]
EXPOSE 443