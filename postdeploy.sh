#!/bin/bash

# Copyright © 2016 Mozg. All rights reserved.
# See LICENSE.txt for license details.

#

echo '#@@# Running: postdeploy'

bash app.sh _postdeploy >> app_log.txt 2>&1

#
