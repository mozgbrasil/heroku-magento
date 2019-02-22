#!/bin/bash

# Copyright © 2016 Mozg. All rights reserved.
# See LICENSE.txt for license details.

#

echo '#@@# Running: postdeploy'

bash app.sh postdeploy

#RUN=$(bash app.sh _postdeploy)
#echo "$RUN"
#echo "$RUN" >> app_log.txt

#LOGFILE=$(<app_log.txt)
#echo "$LOGFILE"

#curl -s -X POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg --data "${LOGFILE}" --verbose # ERROR: /usr/bin/curl: Argument list too long

#LOGVAR=$(curl -s --upload-file app_log.txt https://transfer.sh/app_log.txt)

#curl -s --request POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg --data "#@@# Running: postdeploy : ${LOGVAR}"

#curl -s -X POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg -d "@app_log.txt"

#RUN=$(bash app.sh _postdeploy | curl -s -F 'sprunge=<-' http://sprunge.us)
#RUN=$(bash app.sh _postdeploy | nc termbin.com 9999)
##RUN=$(cat app_log.txt | curl -s -F 'sprunge=<-' http://sprunge.us)
#RUN=$(cat app_log.txt | nc termbin.com 9999)

##curl -s -X POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg --data "Yo_postdeploy :: ${RUN}"

#
