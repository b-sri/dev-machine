FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash certbot tzdata && \
    mkdir -p /tmp/servers && \
    mkdir -p /var/log/certbot && \
    touch /var/log/certbot/certbot.log

COPY parse_servers.sh /opt/parse_servers.sh
RUN chmod +rx /opt/parse_servers.sh

ENTRYPOINT ["/opt/parse_servers.sh"]
