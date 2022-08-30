FROM alpine:latest
# install prerequisites
RUN apk update \
    apk install \
    && apk add openssl curl ca-certificates nginx
RUN mkdir /etc/nginx/certificates && \
	    openssl req \
		    -x509 \
		    -newkey rsa:2048 \
		    -keyout /etc/nginx/certificates/tcordonn.key \
		    -days 365 \
		    -out /etc/nginx/certificates/tcordonn.cert \
		    -nodes \
		    -subj /CN=tcordonn.42.fr
RUN chown -R nginx:nginx /etc/nginx/certificates
# copy config file
COPY ./conf/nginx.conf /etc/nginx/
# can't be runned as nginx due to rights
USER nginx
CMD ["nginx", "-g","daemon off;"]
EXPOSE 443