#!/bin/bash

# Copyright © 2016 Mozg. All rights reserved.
# See LICENSE.txt for license details.

#

echo "#@@# Running: $1 "

bash app.sh $1 >> app_log.txt 2>&1

#
