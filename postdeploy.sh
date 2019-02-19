#!/bin/bash

# Copyright © 2016 Mozg. All rights reserved.
# See LICENSE.txt for license details.

#

echo 'Yo_postdeploy'

bash app.sh postdeploy > app_log.txt 2>&1

#LOGFILE=$(<app_log.txt)
#echo "$LOGFILE"

#curl -X POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg --data "${LOGFILE}" --verbose # ERROR: /usr/bin/curl: Argument list too long

LOGVAR=$(curl --upload-file ./app_log.txt https://transfer.sh/app_log.txt)
#echo "$LOGVAR"

curl -X POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg --data $LOGVAR

#curl -X POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg -d "@app_log.txt"

#
