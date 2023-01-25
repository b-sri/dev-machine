FROM nginx:1.23.3-alpine-slim

RUN apk update && \
    apk upgrade && \
    apk add --no-cache --virtual cron openssl

RUN adduser -D -S -G 'www-data' -h /var/www www-data

# Create the directory where the content's going to be placed
RUN mkdir -p /var/www/beyonder && \
    chown -R www-data:www-data /var/www && \
    chmod -R 754 /var/www
