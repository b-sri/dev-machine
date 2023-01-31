FROM nginx:1.23.3-alpine-slim

RUN apk update && \
    apk upgrade && \
    mkdir -p /etc/nginx/servers && \
    unlink /var/log/nginx/access.log && \
    unlink /var/log/nginx/error.log && \
    mkdir -p /var/www/${DOMAIN_LIST}

RUN \
    build_pkgs="build-base linux-headers openssl-dev pcre-dev wget zlib-dev git curl bash" && \
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

# RUN \
#     input="/tmp/domain-list" && \
#     grep "server_name" /etc/nginx/servers/ > ${input} && \
#     while read -r line; do \
#         domain=`echo ${line} | awk '{print $3}'`;\
#         echo ${domain} >> /var/log/nginx/access.log; \
#         mkdir -p "/var/www/${domain}"; \
#         cp /usr/share/nginx/html/* /var/www/${domain}; \
#     done < ${input} && \
#     rm ${input}

RUN \
    adduser -D -S -G 'www-data' -h /var/www www-data && \
    chown -R www-data:www-data /var/www && \
    chmod -R 754 /var/www

RUN \
    rm -rf /tmp/* && \
    apk del ${build_pkgs} && \
    rm -rf /var/cache/apk/* && \
    rm -f /etc/nginx/conf.d/default.conf

CMD [ "nginx", "-g", "daemon off;" ]
