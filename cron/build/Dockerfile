FROM alpine

RUN apk update && \
    apk upgrade && \
    mkdir -p /var/log/cron && \
    touch /var/log/cron/cron.log && \
    apk add --no-cache bash tzdata

COPY timer_service.sh /opt/
RUN chmod +rx /opt/timer_service.sh

COPY cron-file /etc/cron.d/
RUN chmod 0644 /etc/cron.d/cron-file

RUN crontab /etc/cron.d/cron-file

ENTRYPOINT [ "crond", "-f" ]
