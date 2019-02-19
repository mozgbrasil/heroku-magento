#!/bin/bash

# Copyright © 2016 Mozg. All rights reserved.
# See LICENSE.txt for license details.

# Check if we're root, if not show a warning
if [[ $UID -ne 0 ]]; then
  case $1 in
    ""|help) # You should be allowed to check the help without being root
      ;;
    *)
      #echo "Sorry, but this needs to be run as root."
      echo "Ok"
      #exit 1
      ;;
  esac
fi

WICH_7ZA=`which 7za`
WICH_TAR=`which tar`
WICH_MYSQL=`which mysql`
GIT=`which git` > /dev/null
PHP_BIN=`which php`
OS=`uname -s`
REV=`uname -r`
MACH=`uname -m`
WHOAMI=$(whoami &2>/dev/null)
FOLDER_UP="$(cd ../; pwd)"
BASE_PATH_USER=~
FOLDER_CACHE=$BASE_PATH_USER'/dados/softwares'

# Define text styles
#BOLD=`tput bold` # Error Heroku, tput: No value for $TERM and no -T specified
#NORMAL=`tput sgr0`
#BOLD=$(tput bold)
#NORMAL=$(tput sgr0)
BOLD=''
NORMAL=''

# Reset
RESETCOLOR='\e[0m'       # Text Reset

# Regular Colors
BLACK='\e[0;30m'        # Black
RED='\e[0;31m'          # Red
GREEN='\e[0;32m'        # Green
YELLOW='\e[0;33m'       # Yellow
BLUE='\e[0;34m'         # Blue
PURPLE='\e[0;35m'       # Purple
CYAN='\e[0;36m'         # Cyan
WHITE='\e[0;37m'        # White

# Background
ONBLACK='\e[40m'       # Black
ONRED='\e[41m'         # Red
ONGREEN='\e[42m'       # Green
ONYELLOW='\e[43m'      # Yellow
ONBLUE='\e[44m'        # Blue
ONPURPLE='\e[45m'      # Purple
ONCYAN='\e[46m'        # Cyan
ONWHITE='\e[47m'       # White

# Nice defaults
NOW_2_FILE=$(date +%Y-%m-%d_%H-%M-%S)
DATE_EN_US=$(date '+%Y-%m-%d %H:%M:%S')
DATE_PT_BR=$(date '+%d/%m/%Y %H:%M:%S')

#

functionBefore() {
DATA_HORA_INICIAL=$(date '+%d/%m/%Y %H:%M:%S')
DATA_HORA_EN_US=$(date '+%Y-%m-%d %H:%M:%S')
}

functionAfter() {
DATA_HORA_FINAL=$(date '+%d/%m/%Y %H:%M:%S')
echo
echo "${BOLD} DATA_HORA_INICIAL: $DATA_HORA_INICIAL ${NORMAL}"
echo
echo "${BOLD} DATA_HORA_FINAL: $DATA_HORA_FINAL ${NORMAL}"
echo
}

showVars () {

echo -e "${ONWHITE} - ${NORMAL}"

echo -e "showVars ()"

echo -e "${ONYELLOW} date ${NORMAL}"

echo $(date +%Y-%m-%d_%H-%M-%S)

echo -e "${ONYELLOW} pwd ${NORMAL}"

pwd

ls

echo -e "${ONYELLOW} whoami - print effective userid ${NORMAL}"

whoami

echo -e "${ONYELLOW} printenv - print all or part of environment ${NORMAL}"

printenv

#echo -e "${ONYELLOW} ps - report a snapshot of the current processes ${NORMAL}"

#ps aux

#echo -e "${ONYELLOW} will list all the commands you could run. ${NORMAL}"

#compgen -A function -abck

}

postdeploy () {

echo -e "${ONWHITE} - ${NORMAL}"

echo -e "${ONYELLOW} postdeploy () ${NORMAL}"

#magento_sample_data_install
magento_install

}

check_in_database () {

echo -e "${ONWHITE} - ${NORMAL}"

echo -e "${ONYELLOW} check_in_database () ${NORMAL}"

get_db_vars

check_out_database

}

download_install () {

echo -e "${ONWHITE} - ${NORMAL}"

echo -e "${ONYELLOW} download_install () ${NORMAL}"

check_in_database

echo -e "${ONYELLOW} cat > composer.json <<- _EOF_ ${NORMAL}"

cat > composer.json <<- _EOF_
{
    "minimum-stability": "dev",
    "prefer-stable": true,
    "license": [
        "proprietary"
    ],
    "repositories":[
        {
            "type":"composer",
            "url":"https://packages.firegento.com"
        }
    ],
    "extra":{
        "magento-root-dir": "magento",
        "magento-deploystrategy": "copy",
        "magento-force": true
    },
    "require": {
        "magento-hackathon/magento-composer-installer": "~3.0",
        "aydin-hassan/magento-core-composer-installer": "~1.2",
        "firegento/magento": "~1.9.4.0",
        "aoepeople/aoe_scheduler": "^1.5",
        "aschroder/smtp_pro": "^2.0",
        "mozgbrasil/magento-bundle-php_56": "dev-master"
    }
}
_EOF_

echo -e "${ONYELLOW} composer diagnose ${NORMAL}"

composer diagnose

echo -e "${ONYELLOW} composer update ${NORMAL}"

composer update

echo -e "${ONYELLOW} magento_sample_data_install ${NORMAL}"

magento_sample_data_install

}

magento_sample_data_install () {

echo -e "${ONWHITE} - ${NORMAL}"

echo -e "${ONYELLOW} magento_sample_data_install () ${NORMAL}"

magento_sample_data

magento_install

}

dot_profile () {

echo -e "${ONWHITE} - ${NORMAL}"

echo -e "${ONYELLOW} dot_profile () ${NORMAL}"

# https://devcenter.heroku.com/articles/dynos#startup

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

}

get_db_vars () {

echo -e "${ONWHITE} - ${NORMAL}"

echo -e "${ONYELLOW} get_db_vars () ${NORMAL}"

# -n String, True if the length of String is nonzero.
# -z String, True if string is empty.

echo -e "${BLUE} DB_HOST: ${DB_HOST} ${NORMAL}"

if [ -n ${DB_HOST} ]; then # Arguments localhost

    echo -e "${RED} DB_HOST ${NORMAL}"

    echo -e "${BLUE} URL: ${URL} ${NORMAL}"
    echo -e "${BLUE} DB_HOST: ${DB_HOST} ${NORMAL}"
    echo -e "${BLUE} DB_PORT: ${DB_PORT} ${NORMAL}"
    echo -e "${BLUE} DB_NAME: ${DB_NAME} ${NORMAL}"
    echo -e "${BLUE} DB_USER: ${DB_USER} ${NORMAL}"
    echo -e "${BLUE} DB_PASS: ${DB_PASS} ${NORMAL}"

    echo -e "${ONPURPLE} - ${NORMAL}"

    echo -e "${BLUE} `pwd` ${NORMAL}"

    ls -lah

    echo -e "${ONPURPLE} - ${NORMAL}"

    #

    #read -e -p "Confirme que os dados acima está correto [S/N]: " -i "S" accept

    #if [ "$accept" != "S" ];then
    #    echo -e "${RED} Processo abortado ${NORMAL}"
    #    exit
    #fi

    #

else

    echo -e "${RED} DB_HOST Failed ${NORMAL}"

fi

#

if [ -n ${JAWSDB_URL} ]; then

  echo -e "${RED} JAWSDB ${NORMAL}"

  # https://regex101.com/r/EeO9HR/2

  REGEX_EXPR='postgres:\/\/(.+):(.+)@(.+):(5432| )\/(.+)'
  #$DATABASE_URL # PostgreSQL

  REGEX_EXPR='mysql:\/\/(.+):(.+)@(.+):(3306| )\/(.+)'
  #$JAWSDB_URL # MySQL

  if [[ $JAWSDB_URL =~ $REGEX_EXPR ]]
  then

      echo -e "${GREEN} Get Regex ${NORMAL}"

      #echo The regex matches!
      #echo $BASH_REMATCH
      #echo ${BASH_REMATCH[1]}
      #echo ${BASH_REMATCH[2]}
      #echo ${BASH_REMATCH[3]}
      #echo ${BASH_REMATCH[4]}
      #echo ${BASH_REMATCH[5]}

      URL="https://${HEROKU_APP_NAME}.herokuapp.com/magento/"
      DB_HOST=${BASH_REMATCH[3]}
      DB_PORT=${BASH_REMATCH[4]}
      DB_NAME=${BASH_REMATCH[5]}
      DB_USER=${BASH_REMATCH[1]}
      DB_PASS=${BASH_REMATCH[2]}

      echo -e "${BLUE} URL: ${URL} ${NORMAL}"
      echo -e "${BLUE} DB_HOST: ${DB_HOST} ${NORMAL}"
      echo -e "${BLUE} DB_PORT: ${DB_PORT} ${NORMAL}"
      echo -e "${BLUE} DB_NAME: ${DB_NAME} ${NORMAL}"
      echo -e "${BLUE} DB_USER: ${DB_USER} ${NORMAL}"
      echo -e "${BLUE} DB_PASS: ${DB_PASS} ${NORMAL}"

  else
      echo -e "${RED} Regex Failed ${NORMAL}"
  fi

else 
    echo -e "${RED} JAWSDB Failed ${NORMAL}"
fi

#

if [ -n ${MAGE_DB_HOST} ]; then

    echo -e "${GREEN} Get ENV ${NORMAL}"

    URL="https://${HEROKU_APP_NAME}.herokuapp.com/magento/"
    DB_HOST=${MAGE_DB_HOST}
    DB_PORT=${MAGE_DB_PORT}
    DB_NAME=${MAGE_DB_NAME}
    DB_USER=${MAGE_DB_USER}
    DB_PASS=${MAGE_DB_PASS}

    echo -e "${BLUE} URL: ${URL} ${NORMAL}"
    echo -e "${BLUE} DB_HOST: ${DB_HOST} ${NORMAL}"
    echo -e "${BLUE} DB_PORT: ${DB_PORT} ${NORMAL}"
    echo -e "${BLUE} DB_NAME: ${DB_NAME} ${NORMAL}"
    echo -e "${BLUE} DB_USER: ${DB_USER} ${NORMAL}"
    echo -e "${BLUE} DB_PASS: ${DB_PASS} ${NORMAL}"

else 
    echo -e "${RED} ENV Failed ${NORMAL}"
fi

#

}

check_out_database () {

echo -e "${ONWHITE} - ${NORMAL}"

echo -e "${ONYELLOW} check_out_database () ${NORMAL}"

MYSQL_RETURN=`mysql -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p${DB_PASS} ${DB_NAME} -v -e "SHOW TABLES"`

echo -e "${ONPURPLE} - ${NORMAL}"

echo $MYSQL_RETURN

if [ "$MYSQL_RETURN" == "" ];then
    echo -e "${RED} Processo abortado ${NORMAL}"
    exit
fi

}

magento_sample_data () {

echo -e "${ONWHITE} - ${NORMAL}"

echo -e "${ONYELLOW} magento_sample_data () ${NORMAL}"

echo -e "${ONYELLOW} check_in_database ${NORMAL}"

check_in_database

FILE_CACHE=$FOLDER_CACHE'/magento-sample-data-1.9.2.4-fix.tar.gz'

echo -e "${ONYELLOW} ${FILE_CACHE} ${NORMAL}"

if [ -f "$FILE_CACHE" ];then
    echo -e "${ONGREEN} Arquivo se encontra em cache ${NORMAL}"
    cp $FILE_CACHE .
else
    echo -e "${ONYELLOW} Arquivo não se encontra em cache ${NORMAL}"
    wget https://ufpr.dl.sourceforge.net/project/mageloads/assets/1.9.2.4/magento-sample-data-1.9.2.4-fix.tar.gz
    if [ -d "$FOLDER_CACHE" ]; then
      cp magento-sample-data-1.9.2.4-fix.tar.gz $FOLDER_CACHE
    fi
fi

echo -e "${ONYELLOW} Descompactando arquivo ${NORMAL}"

tar xzf magento-sample-data-1.9.2.4-fix.tar.gz

echo -e "${ONYELLOW} Copiando arquivos ${NORMAL}"

cp -fr magento-sample-data-1.9.2.4/media/* magento/media/

cp -fr magento-sample-data-1.9.2.4/skin/* magento/skin/

echo -e "${ONYELLOW} Importando Banco de Dados ${NORMAL}"

mysql -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p${DB_PASS} ${DB_NAME} < 'magento-sample-data-1.9.2.4/magento_sample_data_for_1.9.2.4.sql'

echo -e "${ONYELLOW} Removendo arquivos ${NORMAL}"

rm -fr magento-sample-data-1.9.2.4-fix.tar.gz magento-sample-data-1.9.2.4

}

magento_install () {

echo -e "${ONWHITE} - ${NORMAL}"

echo -e "${ONYELLOW} magento_install () ${NORMAL}"

echo -e "${ONYELLOW} check_in_database ${NORMAL}"

check_in_database

echo -e "${ONYELLOW} pwd ${NORMAL}"

pwd

ls -lah

#echo -e "${ONYELLOW} Aplicando permissões ${NORMAL}"

#chmod 777 -R .

echo -e "${ONYELLOW} magento/install.php ${NORMAL}"

php -f magento/install.php -- \
--license_agreement_accepted "yes" \
--locale "pt_BR" \
--timezone "America/Sao_Paulo" \
--default_currency "BRL" \
--db_host "${DB_HOST}:${DB_PORT}" \
--db_name "${DB_NAME}" \
--db_user "${DB_USER}" \
--db_pass "${DB_PASS}" \
--url "$URL" \
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

echo -e "${ONYELLOW} magento/index.php ${NORMAL}"

php magento/index.php

echo -e "${ONYELLOW} shell ${NORMAL}"

echo -e "${ONYELLOW} compiler.php --state ${NORMAL}"

php magento/shell/compiler.php --state

echo -e "${ONYELLOW} log.php --clean ${NORMAL}"

php magento/shell/log.php --clean

echo -e "${ONYELLOW} indexer.php --status ${NORMAL}"

php magento/shell/indexer.php --status

echo -e "${ONYELLOW} indexer.php --info ${NORMAL}"

php magento/shell/indexer.php --info

echo -e "${ONYELLOW} indexer.php --reindexall ${NORMAL}"

php magento/shell/indexer.php --reindexall

echo -e "${ONYELLOW} cd magento ${NORMAL}"

cd magento

echo -e "${ONYELLOW} mage ${NORMAL}"

chmod +x mage

bash ./mage

echo -e "${ONYELLOW} mage-setup ${NORMAL}"

bash ./mage mage-setup

echo -e "${ONYELLOW} sync ${NORMAL}"

bash ./mage sync

echo -e "${ONYELLOW} list-installed ${NORMAL}"

bash ./mage list-installed

echo -e "${ONYELLOW} list-upgrades ${NORMAL}"

bash ./mage list-upgrades

}

#



#

if [ "$#" -eq  "0" ]
   then
     echo "No arguments supplied"
 else
     echo "Arguments supplied"

    for ARGUMENT in "$@" # Parse the command line arguments
    do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)

    echo "${BOLD} Arguments... ${NORMAL}"
    echo $KEY
    echo $VALUE

    case "$KEY" in
    --db_host)
      DB_HOST=${VALUE}
    ;;
    --db_port)
      DB_PORT=${VALUE}
    ;;
    --db_name)
      DB_NAME=${VALUE}
    ;;
    --db_user)
      DB_USER=${VALUE}
    ;;
    --db_pass)
      DB_PASS=${VALUE}
    ;;
    --url)
      URL=${VALUE}
    ;;
    *)
      NADA='NULO'
    ;;
    esac

    done

fi  

#

case $1 in
    download_install)
        echo
        echo "${BOLD} . ${NORMAL}"
        echo
        functionBefore
          download_install
        functionAfter
        echo
        echo "${BOLD} . ${NORMAL}"
        echo
        ;;

    magento_sample_data_install)
        echo
        echo "${BOLD} . ${NORMAL}"
        echo
        functionBefore
          magento_sample_data_install
        functionAfter
        echo
        echo "${BOLD} . ${NORMAL}"
        echo
        ;;

    magento_install)
        echo
        echo "${BOLD} . ${NORMAL}"
        echo
        functionBefore
          magento_install
        functionAfter
        echo
        echo "${BOLD} . ${NORMAL}"
        echo
        ;;

    postdeploy)
        echo
        echo "${BOLD} . ${NORMAL}"
        echo
        functionBefore
          showVars
          postdeploy
        functionAfter
        echo
        echo "${BOLD} . ${NORMAL}"
        echo
        ;;

    *|help)
        echo
        echo "${BOLD} . ${NORMAL}"
        echo
        functionBefore
          showVars
        functionAfter
        echo
        echo "${BOLD} . ${NORMAL}"
        echo
        ;;
esac

#
