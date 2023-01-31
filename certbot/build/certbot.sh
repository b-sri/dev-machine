#!/bin/bash

set -x

if [ "$CERTBOT_TEST_CERT" != "0" ]; then
  test_cert_arg="--test-cert"
fi

input="/tmp/domain-list"

grep "server_name" /etc/nginx/servers/* > ${input}
domain_count=`cat ${input} | wc -l`
echo "No. of domains identified: ${domain_count}" >> /var/log/certbot/certbot.log
while read -r line; do
    domain=`echo ${line} | awk '{print $3}'`
    mkdir -p "/var/www/certbot/${domain}"
    echo "Now certifying: ${domain}..." >> /var/log/certbot/certbot.log

    certbot certonly \
        --webroot \
        -w "/var/www/certbot/$domain" \
        -d "$domain" -d "www.$domain" \
        $test_cert_arg \
        --email "${EMAIL_FOR_CERTBOT}" \
        --rsa-key-size "${CERTBOT_RSA_KEY_SIZE:-4096}" \
        --agree-tos \
        --noninteractive \
        --verbose  2>&1 | tee -a /var/log/certbot/certbot.log
    done < ${input}
    echo "Certification process complete!" >> /var/log/certbot/certbot.log

rm ${input}
