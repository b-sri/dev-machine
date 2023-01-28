FROM certbot/certbot

RUN apk add --no-cache bash && \
    mkdir -p /tmp/servers

COPY parse_servers.sh /opt/parse_servers.sh
RUN chmod +rx /opt/parse_servers.sh

ENTRYPOINT ["/opt/parse_servers.sh"]
