#!/bin/bash

set -e

input="/tmp/domain-list"
grep "server_name" /tmp/servers/ > ${input}
while read -r line; do
    domain=`echo ${line} | awk '{print $3}'`
    certbot certonly \
        --webroot \
        -w "/var/www/certbot/$domain" \
        -d "$domain" -d "www.$domain" \
        $test_cert_arg \
        "${EMAIL_FOR_CERTBOT}" \
        --rsa-key-size "${CERTBOT_RSA_KEY_SIZE:-4096}" \
        --agree-tos \
        --noninteractive \
        --verbose || true
    done < ${input}
rm ${input}
