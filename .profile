#!/bin/bash

# Copyright © 2016 Mozg. All rights reserved.
# See LICENSE.txt for license details.

#

bash app.sh dot_profile > app_log.txt 2>&1

#LOGFILE=$(<app_log.txt)
#echo "$LOGFILE"

#curl -X POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg --data "${LOGFILE}" --verbose # ERROR: /usr/bin/curl: Argument list too long

#LOGVAR=$(curl --upload-file ./app_log.txt https://transfer.sh/app_log.txt)
#echo "$LOGVAR"

#curl -X POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg --data $LOGVAR

#curl -X POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg -d "@app_log.txt"

#RUN=$(bash app.sh dot_profile | curl -F 'sprunge=<-' http://sprunge.us)
#RUN=$(bash app.sh dot_profile | nc termbin.com 9999)
RUN=$(cat ~/app_log.txt | nc termbin.com 9999)

curl -X POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg --data "Yo_profile :: ${RUN}"

#
