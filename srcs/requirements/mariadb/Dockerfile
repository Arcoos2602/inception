FROM alpine::latest
# Create user and set ownership and permissions as required
RUN adduser -D myuser && chown -R myuser /myapp-data
# ... copy application files
ENTRYPOINT ["/myapp"]
USER myuser
RUN apk update