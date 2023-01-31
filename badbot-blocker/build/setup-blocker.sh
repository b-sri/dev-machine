#!/bin/sh

log_file="/var/log/badbot-blocker/badbot-blocker.log"

echo `date` ": Fetching setup files" >> ${log_file}
curl -L https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker \
     -o /usr/local/sbin/install-ngxblocker \
     | tee -a ${log_file}

echo `date` ": Setting up..." >> ${log_file}
chmod +rx /usr/local/sbin/install-ngxblocker | tee -a ${log_file}
/usr/local/sbin/install-ngxblocker -x || true 2>&1 | tee -a ${log_file}

echo `date` ": Installing bad bots list..." >> ${log_file}
chmod +rx /usr/local/sbin/*ngxblocker | tee -a ${log_file}
/usr/local/sbin/setup-ngxblocker -x || true 2>&1 | tee -a ${log_file}

echo `date` ": Installation complete! Bot errors will be logged in Nginx logs" >> ${log_file}
