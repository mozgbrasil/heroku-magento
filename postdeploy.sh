#!/bin/bash

# Copyright © 2016 Mozg. All rights reserved.
# See LICENSE.txt for license details.

#

echo '#@@# Running: postdeploy'

curl --request POST "https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg" --data 'postdeploy111'

bash app.sh _postdeploy >> app_log.txt 2>&1

curl --request POST "https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg" --data 'postdeploy222'

#
