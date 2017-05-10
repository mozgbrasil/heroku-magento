#!/bin/bash

#

# Copyright © 2017 Mozg. All rights reserved.
# See LICENSE.txt for license details.

#

# No app.json em postdeploy, não é criado a pasta root do Magento, sendo necessário a execução manual desse arquivo após o Deploy

# bash -x bootstrap.sh

#

echo -e "--(ENV)--" ;\

# https://www.cyberciti.biz/faq/linux-list-all-environment-variables-env-command/

printenv

#

echo -e "--(REGEX_EXPR)--" ;\

#MAGENTO_URL="http://magento-heroku.herokuapp.com/"
MAGENTO_URL="$1"

# https://regex101.com/r/EeO9HR/2

REGEX_EXPR='postgres:\/\/(.+):(.+)@(.+):(5432| )\/(.+)'
#$DATABASE_URL # PostgreSQL

REGEX_EXPR='mysql:\/\/(.+):(.+)@(.+):(3306| )\/(.+)'
#$JAWSDB_URL # MySQL

if [[ $JAWSDB_URL =~ $REGEX_EXPR ]]
then
    #echo The regex matches!
    #echo $BASH_REMATCH      
    #echo ${BASH_REMATCH[1]}
    #echo ${BASH_REMATCH[2]}
    #echo ${BASH_REMATCH[3]}
    #echo ${BASH_REMATCH[4]}
    #echo ${BASH_REMATCH[5]}

    MAGENTO_DB_HOST=${BASH_REMATCH[3]}
    MAGENTO_DB_PORT=${BASH_REMATCH[4]}
    MAGENTO_DB_NAME=${BASH_REMATCH[5]}
    MAGENTO_DB_USER=${BASH_REMATCH[1]}
    MAGENTO_DB_PASS=${BASH_REMATCH[2]}

    echo -e "--(MAGENTO_URL: ${MAGENTO_URL})--" ;\
    echo -e "--(DB_HOST: ${MAGENTO_DB_HOST})--" ;\
    echo -e "--(DB_PORT: ${MAGENTO_DB_PORT})--" ;\
    echo -e "--(DB_NAME: ${MAGENTO_DB_NAME})--" ;\
    echo -e "--(DB_USER: ${MAGENTO_DB_USER})--" ;\
    echo -e "--(DB_PASS: ${MAGENTO_DB_PASS})--" ;\

    # Check Database

    echo -e "--(Check Database)--" ;\

    mysql -h ${MAGENTO_DB_HOST} -P ${MAGENTO_DB_PORT} -u ${MAGENTO_DB_USER} -p${MAGENTO_DB_PASS} ${MAGENTO_DB_NAME} -v -e "SHOW TABLES"

else
    echo -e "--(Unable to parse STRING from config)--" ;\
fi

#

echo -e "--(WICH)--" ;\

#

WICH_7ZA=`which 7za`
WICH_TAR=`which tar`
WICH_MYSQL=`which mysql`

echo -e "--( ${WICH_7ZA} )--" ;\
echo -e "--( ${WICH_TAR} )--" ;\
echo -e "--( ${WICH_MYSQL} )--" ;\

#

echo -e "--(DIRECTORY)--" ;\

echo -e "--(`pwd`)--" ;\
echo -e "--(`ls -all`)--" ;\

cd root

chmod 777 -R .

pwd

ls -all

# Sample Data

echo -e "--(Sample Data)--" ;\

echo -e "--(Processo 1)--" ;\

wget https://raw.githubusercontent.com/Vinai/compressed-magento-sample-data/1.9.1.0/compressed-no-mp3-magento-sample-data-1.9.1.0.tgz ;\

echo -e "--(Processo 3)--" ;\

tar xzf compressed-no-mp3-magento-sample-data-1.9.1.0.tgz ;\

echo -e "--(Processo 4)--" ;\

cp -fr magento-sample-data-1.9.1.0/media/* media/ ;\

echo -e "--(Processo 5)--" ;\

mysql -h ${MAGENTO_DB_HOST} -P ${MAGENTO_DB_PORT} -u ${MAGENTO_DB_USER} -p${MAGENTO_DB_PASS} ${MAGENTO_DB_NAME} < 'magento-sample-data-1.9.1.0/magento_sample_data_for_1.9.1.0.sql' ;\

echo -e "--(Processo 6)--" ;\

#rm -fr compressed-no-mp3-magento-sample-data-1.9.1.0.tar compressed-no-mp3-magento-sample-data-1.9.1.0.tar.7z magento-sample-data-1.9.1.0

echo -e "--(Processo 7)--" ;\

pwd

ls -all

# Install Magento

echo -e "--(Install Magento)--" ;\

php -f install.php -- \
--license_agreement_accepted "yes" \
--locale "pt_BR" \
--timezone "America/Sao_Paulo" \
--default_currency "BRL" \
--db_host "${MAGENTO_DB_HOST}:${MAGENTO_DB_PORT}" \
--db_name "${MAGENTO_DB_NAME}" \
--db_user "${MAGENTO_DB_USER}" \
--db_pass "${MAGENTO_DB_PASS}" \
--url "$MAGENTO_URL" \
--skip_url_validation "yes" \
--use_rewrites "yes" \
--use_secure "no" \
--secure_base_url "" \
--use_secure_admin "no" \
--admin_firstname "Magento" \
--admin_lastname "User" \
--admin_email "user@example.com" \
--admin_username "admin" \
--admin_password "123456a"

# Magento /shell

echo -e "--(Magento /shell)--" ;\

echo -e "--(Processo 1)--" ;\
php shell/compiler.php --state ;\
echo -e "--(Processo 2)--" ;\
php shell/log.php --clean ;\
echo -e "--(Processo 3)--" ;\
php shell/indexer.php --status ;\
echo -e "--(Processo 4)--" ;\
php shell/indexer.php --info ;\
echo -e "--(Processo 5)--" ;\
php shell/indexer.php --reindexall

# Magento ./mage command-line

#echo -e "--(Magento ./mage)--" ;\

#echo -e "--(Processo 1)--" ;\
#sh mage ;\
#echo -e "--(Processo 2)--" ;\
#sh mage mage-setup ;\
#echo -e "--(Processo 3)--" ;\
#sh mage sync ;\
#echo -e "--(Processo 4)--" ;\
#sh mage list-installed ;\
#echo -e "--(Processo 5)--" ;\
#sh mage list-upgrades ;\

#