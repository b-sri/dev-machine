FROM alpine

RUN \
    apk update && \
    apk upgrade && \
    mkdir -p /var/log/badbot-blocker && \
    mkdir -p /opt/setup-blocker && \
    mkdir -p /usr/local/sbin && \
    touch /var/log/badbot-blocker/badbot-blocker.log && \
    apk add --no-cache --virtual tzdata curl

COPY setup-blocker.sh /opt/setup-blocker/
COPY update-blocker.sh /opt/setup-blocker/

RUN chmod +rx /opt/setup-blocker/*.sh && \
    /opt/setup-blocker/setup-blocker.sh

ENTRYPOINT [ "/opt/setup-blocker/setup-blocker.sh" ]
