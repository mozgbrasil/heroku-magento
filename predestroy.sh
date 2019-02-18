#!/bin/bash

# Copyright © 2016 Mozg. All rights reserved.
# See LICENSE.txt for license details.

#

echo 'Yo_predestroy'

bash app.sh teardown >> app_log.txt

LOGGI=$(curl --upload-file ./app_log.txt https://transfer.sh/app_log.txt)

echo "$LOGGI"

curl --request POST 'https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg' --data $LOGGI

#
