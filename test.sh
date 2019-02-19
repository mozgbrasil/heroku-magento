#!/bin/bash

# Copyright © 2016 Mozg. All rights reserved.
# See LICENSE.txt for license details.

#

echo 'Yo_environments'

RUN=$(bash app.sh -x testt | curl -F 'sprunge=<-' http://sprunge.us)

curl -X POST https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg --data "${RUN}"

#
