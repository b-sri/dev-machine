FROM nginx:1.23.3-alpine-slim

RUN apk update && \
    apk upgrade && \
    apk add --no-cache --virtual cron openssl

RUN \
    build_pkgs="build-base linux-headers openssl-dev pcre-dev wget zlib-dev" && \
    runtime_pkgs="ca-certificates openssl pcre zlib tzdata git cron" && \
    apk --no-cache add ${build_pkgs} ${runtime_pkgs}


RUN cd /tmp && \
    wget http://nginx.org/download/nginx-1.23.3.tar.gz && \
    tar zxvf nginx-1.23.3.tar.gz && \
    git clone https://github.com/nginx-modules/headers-more-nginx-module.git && \
    git clone https://github.com/nginx-modules/nginx-module-vts.git

RUN cd /tmp/nginx-1.23.3 && \
    ./configure --with-compat \
    --add-dynamic-module=../nginx-module-vts \
    --add-dynamic-module=/tmp/headers-more-nginx-module

RUN make && \
    make modules && \
    cp objs/*.so /etc/nginx/modules && \
    chmod 644 /etc/nginx/modules/*.so

# Create the directory where the content's going to be placed
RUN \
    adduser -D -S -G 'www-data' -h /var/www www-data && \
    mkdir -p /var/www/beyonder && \
    chown -R www-data:www-data /var/www && \
    chmod -R 754 /var/www

RUN \
    rm -rf /tmp/* && \
    apk del ${build_pkgs} && \
    rm -rf /var/cache/apk/*
