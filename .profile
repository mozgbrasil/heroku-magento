#!/bin/bash

# Copyright © 2016 Mozg. All rights reserved.
# See LICENSE.txt for license details.

# https://devcenter.heroku.com/articles/dynos#startup

if [ "$CLEARDB_DATABASE_URL" = "" ]; then 
    echo "Please set CLEARDB_DATABASE_URL";
exit 1; fi

# example d03b41856deda7fc8498b7a3758a75f
if [ "$MAGENTO_CRYPT_KEY" = "" ]; then 
    echo "Please set MAGENTO_CRYPT_KEY";
exit 1; fi


# extract the protocol
proto="`echo $CLEARDB_DATABASE_URL | grep '://' | sed -e's,^\(.*://\).*,\1,g'`"
# remove the protocol
url=`echo $CLEARDB_DATABASE_URL | sed -e s,$proto,,g`
 
# extract the user (if any)
userpass="`echo $url | grep @ | cut -d@ -f1`"
pass=`echo $userpass | grep : | cut -d: -f2`
if [ -n "$pass" ]; then
    user=`echo $userpass | grep : | cut -d: -f1`
else
    user=$userpass
fi
 
# extract the host
hostport=`echo $url | sed -e s,$userpass@,,g | cut -d/ -f1`
port=`echo $hostport | grep : | cut -d: -f2`
if [ -n "$port" ]; then
    host=`echo $hostport | grep : | cut -d: -f1`
else
    host=$hostport
fi
 
if [ -z "$port" ]; then
  port=3306
fi

# extract the path (if any)
path="`echo $url | grep / | cut -d/ -f2-`"
path="`echo $path | cut -d? -f1`"

# export envvars for psql
export DB_HOST=${MAGE_DB_HOST}
export DB_PORT=${MAGE_DB_PORT}
export DB_NAME=${MAGE_DB_NAME}
export DB_USER=${MAGE_DB_USER}
export DB_PASS=${MAGE_DB_PASS}

echo '- DB environment variables:'

env | grep ^DB_

echo '- Copy local.xml'

cd magento

cp app/etc/local.xml.template app/etc/local.xml

echo '- Populate values'

sed -i -e "s/{{key}}/<![CDATA[$MAGENTO_CRYPT_KEY]]>/" app/etc/local.xml
sed -i -e "s/{{date}}/<![CDATA[Thu, 11 Apr 2019 11:07:01 +0000]]>/" app/etc/local.xml

sed -i -e "s/{{db_host}}/<![CDATA[$DB_HOST]]>/" app/etc/local.xml
sed -i -e "s/{{db_user}}/<![CDATA[$DB_USER]]>/" app/etc/local.xml
sed -i -e "s/{{db_pass}}/<![CDATA[$DB_PASS]]>/" app/etc/local.xml
sed -i -e "s/{{db_name}}/<![CDATA[$DB_NAME]]>/" app/etc/local.xml

sed -i -e "s/{{db_prefix}}/<![CDATA[]]>/" app/etc/local.xml
sed -i -e "s/{{db_model}}/<![CDATA[mysql4]]>/" app/etc/local.xml
sed -i -e "s/{{db_type}}/<![CDATA[pdo_mysql]]>/" app/etc/local.xml
sed -i -e "s/{{db_pdo_type}}/<![CDATA[]]>/" app/etc/local.xml
sed -i -e "s/{{db_init_statemants}}/<![CDATA[SET NAMES utf8]]>/" app/etc/local.xml

sed -i -e "s/{{session_save}}/<![CDATA[db]]>/" app/etc/local.xml

sed -i -e "s/{{admin_frontname}}/<![CDATA[admin]]>/" app/etc/local.xml
