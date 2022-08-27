FROM alpine:latest
# install prerequisites
RUN apk update \
    apk install \
    && apk add openssl curl ca-certificates \
    && apk add nginx
RUN mkdir /etc/nginx/certificates && \
	    openssl req \
		    -x509 \
		    -newkey rsa:2048 \
		    -keyout /etc/nginx/certificates/tcordonn.key \
		    -days 365 \
		    -out /etc/nginx/certificates/tcordonn.cert \
		    -nodes \
		    -subj /CN=tcordonn.42.fr
# copy config file
COPY ./conf/nginx.conf /etc/nginx/
# CMD RUNNED BY ROOT NOT SECURE PID 1
CMD ["nginx", "-g","daemon off;"] 
EXPOSE 443