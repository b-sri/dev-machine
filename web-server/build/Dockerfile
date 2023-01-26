FROM nginx:1.23.3-alpine-slim

RUN apk update && \
    apk upgrade

RUN \
    build_pkgs="build-base linux-headers openssl-dev pcre-dev wget zlib-dev git curl" && \
    runtime_pkgs="ca-certificates openssl pcre zlib tzdata" && \
    apk --no-cache --virtual add ${build_pkgs} ${runtime_pkgs}


RUN cd /tmp && \
    wget http://nginx.org/download/nginx-1.23.3.tar.gz && \
    tar zxvf nginx-1.23.3.tar.gz && \
    git clone https://github.com/openresty/headers-more-nginx-module.git && \
    git clone https://github.com/nginx-modules/nginx-module-vts.git && \
    cd /tmp/nginx-1.23.3 && \
    ./configure --with-compat \
    --add-dynamic-module=/tmp/nginx-module-vts \
    --add-dynamic-module=/tmp/headers-more-nginx-module && \
    make modules && \
    cp /tmp/nginx-1.23.3/objs/*.so /etc/nginx/modules && \
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

ADD https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker /usr/local/sbin/install-ngxblocker

RUN chmod +x /usr/local/sbin/install-ngxblocker && \
    install-ngxblocker -x && \
    chmod +x /usr/local/sbin/*ngxblocker && \ 
    setup-ngxblocker -x

RUN echo "00 22 * * * /usr/local/sbin/update-ngxblocker -e balaji.ts@beyonder.travel" > /tmp/crontab_tmp && \
    crontab /tmp/crontab_tmp && \
    rm /tmp/crontab_tmp
