#!/bin/bash

# Copyright © 2016 Mozg. All rights reserved.
# See LICENSE.txt for license details.

#

bash app.sh teardown > app_log.txt 2>&1

#LOGFILE=$(<app_log.txt)
#echo "$LOGFILE"

#curl -X POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg --data "${LOGFILE}" --verbose # ERROR: /usr/bin/curl: Argument list too long

zip app_log.zip app_log.txt

LOGVAR=$(curl --upload-file ./app_log.zip https://transfer.sh/app_log.zip)

echo '55'

curl --request POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg --data "Yo_predestroy :: ${LOGVAR}"

echo '55aa'

#curl -X POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg -d "@app_log.txt"

#RUN=$(bash app.sh teardown | curl -F 'sprunge=<-' http://sprunge.us)
#RUN=$(bash app.sh teardown | nc termbin.com 9999)
##RUN=$(cat app_log.txt | curl -F 'sprunge=<-' http://sprunge.us)
#RUN=$(cat app_log.txt | nc termbin.com 9999)

##curl -X POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg --data "Yo_predestroy :: ${RUN}"

#
