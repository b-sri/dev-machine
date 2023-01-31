FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash certbot tzdata && \
    mkdir -p /var/log/certbot && \
    touch /var/log/certbot/certbot.log

COPY certbot.sh /opt/
RUN chmod +rx /opt/certbot.sh

ENTRYPOINT ["/opt/certbot.sh"]

CMD ["tail", "-f"], "/dev/null"]