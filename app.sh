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



setVars () {
echo -e "${ONYELLOW} setVars ${NORMAL}"

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
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
#BOLD=''
#NORMAL=''

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

}

setVars

#

function_before() {
echo -e "${ONWHITE} - ${NORMAL}"
echo
}

function_after() {
echo
echo -e "${ONYELLOW}}${NORMAL}"
echo
echo -e "${ONWHITE} - ${NORMAL}"
}

show_vars () {

function_before
echo -e "${ONYELLOW} show_vars () { ${NORMAL}"

echo -e "${ONYELLOW} date ${NORMAL}"

echo $(date +%Y-%m-%d_%H-%M-%S)

echo -e "${ONYELLOW} pwd ${NORMAL}"

pwd && ls

df -h

du -hsx * | sort -rh | head -10

echo -e "${ONYELLOW} whoami - print effective userid ${NORMAL}"

whoami

##echo -e "${ONYELLOW} printenv - print all or part of environment ${NORMAL}"

#printenv

#echo -e "${ONYELLOW} ps - report a snapshot of the current processes ${NORMAL}"

#ps aux

#echo -e "${ONYELLOW} will list all the commands you could run. ${NORMAL}"

#compgen -A function -abck

function_after

}

postdeploy () { # postdeploy command. Use this to run any one-time setup tasks that make the app, and any databases, ready and useful for testing.

function_before
echo -e "${ONYELLOW} postdeploy () { ${NORMAL}"

post_update_cmd # post-update-cmd: occurs after the update command has been executed, or after the install command has been executed without a lock file present.

function_after

}

check_in_database () {

function_before
echo -e "${ONYELLOW} check_in_database () { ${NORMAL}"

get_db_vars

echo -e "${ONYELLOW} Show DB_ ${NORMAL}"

echo -e "${GREEN} MAGE_DB_HOST: ${MAGE_DB_HOST} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_PORT: ${MAGE_DB_PORT} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_NAME: ${MAGE_DB_NAME} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_USER: ${MAGE_DB_USER} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_PASS: ${MAGE_DB_PASS} ${NORMAL}"

MYSQL_RETURN=`mysql -h ${MAGE_DB_HOST} -P ${MAGE_DB_PORT} -u ${MAGE_DB_USER} -p${MAGE_DB_PASS} ${MAGE_DB_NAME} -v -e "SHOW TABLES"`

echo -e "${ONPURPLE} - ${NORMAL}"

echo $MYSQL_RETURN

if [ "$MYSQL_RETURN" == "" ];then
    echo -e "${RED} Processo abortado ${NORMAL}"
    exit
fi

function_after

}

download_install () {

function_before
echo -e "${ONYELLOW} download_install () { ${NORMAL}"

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

function_after

}

magento_sample_data () {

function_before
echo -e "${ONYELLOW} magento_sample_data () { ${NORMAL}"

magento_sample_data_copy
magento_sample_data_import

function_after

}

magento_sample_data_install () {

function_before
echo -e "${ONYELLOW} magento_sample_data_install () { ${NORMAL}"

magento_sample_data
magento_install

function_after

}

profile () {

function_before
echo -e "${ONYELLOW} profile () { ${NORMAL}"

magento_sample_data_copy
magento_config_xml

function_after

}

post_update_cmd () { # post-update-cmd: occurs after the update command has been executed, or after the install command has been executed without a lock file present.
# Na heroku o Mysql 5.1 ainda não foi instalado nesse ponto

function_before
echo -e "${ONYELLOW} post_update_cmd () { ${NORMAL}"

echo -e "${ONYELLOW} - { ${NORMAL}"

cd ..

pwd && ls && ls vendor

du -hsx * | sort -rh | head -10

du -hsx vendor/* | sort -rh | head -10

echo -e "${ONYELLOW} - { ${NORMAL}"

if [ -d vendor/haifeng-ben-zhang/magento1.9.2.4-sample-data ]; then
    echo -e "${ONYELLOW} haifeng-ben-zhang/magento1.9.2.4-sample-data ${NORMAL}"
    cp -fr vendor/haifeng-ben-zhang/magento1.9.2.4-sample-data/media/* magento/media/
    cp -fr vendor/haifeng-ben-zhang/magento1.9.2.4-sample-data/skin/* magento/skin/
fi

if [ -d vendor/ceckoslab/ceckoslab_quicklogin ]; then
    echo -e "${ONYELLOW} ceckoslab/ceckoslab_quicklogin ${NORMAL}"
    cp -fr vendor/ceckoslab/ceckoslab_quicklogin/app/* magento/app/
fi

rm -fr vendor/haifeng-ben-zhang/magento1.9.2.4-sample-data/media
rm -fr vendor/haifeng-ben-zhang/magento1.9.2.4-sample-data/skin
rm -fr vendor/haifeng-ben-zhang vendor/ceckoslab

du -hsx vendor/* | sort -rh | head -10

echo -e "${ONYELLOW} - { ${NORMAL}"

show_vars

if [ -d magento ];then
    echo -e "${ONGREEN} Diretório magento encontrado ${NORMAL}"
    #magento_sample_data_install
    magento_sample_data_import_haifeng
    magento_install
else
    echo -e "${ONRED} Diretório magento não encontrado ${NORMAL}"
fi

magento_config_xml

echo -e "${ONYELLOW} - { ${NORMAL}"

function_after

}

post_install_cmd () { # post-install-cmd: occurs after the install command has been executed with a lock file present.

function_before
echo -e "${ONYELLOW} post_install_cmd () { ${NORMAL}"

#post_update_cmd

function_after

}


dot_env () {

function_before
echo -e "${ONYELLOW} dot_env () { ${NORMAL}"

echo -e "${ONYELLOW} env MAGE_ ${NORMAL}"

env | grep ^MAGE_

echo -e "${ONYELLOW} .env ${NORMAL}"

if [ ! -f .env ];then

  echo -e "${ONYELLOW} .env failed ${NORMAL}"

else

  echo -e "${ONYELLOW} .env ok ${NORMAL}"

  export $(cat .env | xargs)

fi

echo -e "${ONYELLOW} env MAGE_ ${NORMAL}"

env | grep ^MAGE_

function_after

}

magento_config_xml () {

function_before
echo -e "${ONYELLOW} magento_config_xml () { ${NORMAL}"

# if local not exits delete it
if [ ! -f "magento/app/etc/local.xml" ] ; then

dot_env

echo -e "${ONYELLOW} Check local.xml ${NORMAL}"

pwd && ls

../vendor/bin/n98-magerun --version

../vendor/bin/n98-magerun local-config:generate "$MAGE_DB_HOST:$MAGE_DB_PORT" "$MAGE_DB_USER" "$MAGE_DB_PASS" "$MAGE_DB_NAME" "files" "admin" "secret" -vvv

fi

function_after

}

get_db_vars () {

function_before
echo -e "${ONYELLOW} get_db_vars () { ${NORMAL}"

# -n String, True if the length of String is nonzero.
# -z String, True if string is empty.

echo -e "${ONBLUE} DB_HOST: ${DB_HOST} ${NORMAL}"

if [ -z $DB_HOST ]; then # Arguments localhost

    echo -e "${RED} DB_HOST Failed ${NORMAL}"

else

    echo -e "${ONGREEN} DB_HOST ${NORMAL}"

    echo -e "${GREEN} MAGE_URL: ${MAGE_URL} ${NORMAL}"
    echo -e "${GREEN} MAGE_DB_HOST: ${MAGE_DB_HOST} ${NORMAL}"
    echo -e "${GREEN} MAGE_DB_PORT: ${MAGE_DB_PORT} ${NORMAL}"
    echo -e "${GREEN} MAGE_DB_NAME: ${MAGE_DB_NAME} ${NORMAL}"
    echo -e "${GREEN} MAGE_DB_USER: ${MAGE_DB_USER} ${NORMAL}"
    echo -e "${GREEN} MAGE_DB_PASS: ${MAGE_DB_PASS} ${NORMAL}"

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

fi

#

if [ -z $JAWSDB_URL ]; then

  echo -e "${RED} JAWSDB Failed ${NORMAL}"

else 

  echo -e "${ONGREEN} JAWSDB ${NORMAL}"

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

      export MAGE_URL=""
      export MAGE_DB_HOST=${BASH_REMATCH[3]}
      export MAGE_DB_HOST=${BASH_REMATCH[4]}
      export MAGE_DB_NAME=${BASH_REMATCH[5]}
      export MAGE_DB_USER=${BASH_REMATCH[1]}
      export MAGE_DB_PASS=${BASH_REMATCH[2]}

      echo -e "${GREEN} MAGE_URL: ${MAGE_URL} ${NORMAL}"
      echo -e "${GREEN} MAGE_DB_HOST: ${MAGE_DB_HOST} ${NORMAL}"
      echo -e "${GREEN} MAGE_DB_PORT: ${MAGE_DB_PORT} ${NORMAL}"
      echo -e "${GREEN} MAGE_DB_NAME: ${MAGE_DB_NAME} ${NORMAL}"
      echo -e "${GREEN} MAGE_DB_USER: ${MAGE_DB_USER} ${NORMAL}"
      echo -e "${GREEN} MAGE_DB_PASS: ${MAGE_DB_PASS} ${NORMAL}"

  else
      echo -e "${RED} Regex Failed ${NORMAL}"
  fi

fi

#

if [ -z $MAGE_DB_HOST ]; then

    echo -e "${RED} ENV Failed ${NORMAL}"

else 

    echo -e "${ONGREEN} Get ENV ${NORMAL}"

    echo -e "${GREEN} MAGE_URL: ${MAGE_URL} ${NORMAL}"
    echo -e "${GREEN} MAGE_DB_HOST: ${MAGE_DB_HOST} ${NORMAL}"
    echo -e "${GREEN} MAGE_DB_PORT: ${MAGE_DB_PORT} ${NORMAL}"
    echo -e "${GREEN} MAGE_DB_NAME: ${MAGE_DB_NAME} ${NORMAL}"
    echo -e "${GREEN} MAGE_DB_USER: ${MAGE_DB_USER} ${NORMAL}"
    echo -e "${GREEN} MAGE_DB_PASS: ${MAGE_DB_PASS} ${NORMAL}"

fi

#

function_after

}

magento_sample_data_copy () {

function_before
echo -e "${ONYELLOW} magento_sample_data_copy () { ${NORMAL}"

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

tar xvzf magento-sample-data-1.9.2.4-fix.tar.gz

echo -e "${ONYELLOW} Copiando arquivos ${NORMAL}"

cp -fr magento-sample-data-1.9.2.4/media/* magento/media/

cp -fr magento-sample-data-1.9.2.4/skin/* magento/skin/

function_after

}

magento_sample_data_import_haifeng () {

function_before
echo -e "${ONYELLOW} magento_sample_data_import_haifeng () { ${NORMAL}"

echo -e "${ONYELLOW} Importando Banco de Dados ${NORMAL}"

get_db_vars

echo -e "${ONYELLOW} Show DB_ ${NORMAL}"

echo -e "${GREEN} MAGE_URL: ${MAGE_URL} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_HOST: ${MAGE_DB_HOST} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_PORT: ${MAGE_DB_PORT} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_NAME: ${MAGE_DB_NAME} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_USER: ${MAGE_DB_USER} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_PASS: ${MAGE_DB_PASS} ${NORMAL}"

mysql -h ${MAGE_DB_HOST} -P ${MAGE_DB_PORT} -u ${MAGE_DB_USER} -p${MAGE_DB_PASS} ${MAGE_DB_NAME} < 'vendor/haifeng-ben-zhang/magento1.9.2.4-sample-data/magento_sample_data_for_1.9.2.4.sql'

function_after

}

magento_sample_data_import () {

function_before
echo -e "${ONYELLOW} magento_sample_data_import () { ${NORMAL}"

echo -e "${ONYELLOW} Importando Banco de Dados ${NORMAL}"

get_db_vars

echo -e "${ONYELLOW} Show DB_ ${NORMAL}"

echo -e "${GREEN} MAGE_URL: ${MAGE_URL} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_HOST: ${MAGE_DB_HOST} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_PORT: ${MAGE_DB_PORT} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_NAME: ${MAGE_DB_NAME} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_USER: ${MAGE_DB_USER} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_PASS: ${MAGE_DB_PASS} ${NORMAL}"

mysql -h ${MAGE_DB_HOST} -P ${MAGE_DB_PORT} -u ${MAGE_DB_USER} -p${MAGE_DB_PASS} ${MAGE_DB_NAME} < 'magento-sample-data-1.9.2.4/magento_sample_data_for_1.9.2.4.sql'

echo -e "${ONYELLOW} Removendo arquivos ${NORMAL}"

rm -fr magento-sample-data-1.9.2.4-fix.tar.gz magento-sample-data-1.9.2.4

function_after

}

magento_install () {

function_before
echo -e "${ONYELLOW} magento_install () { ${NORMAL}"

check_in_database

echo -e "${ONYELLOW} cd magento ${NORMAL}"

pwd && ls -lah
cd magento
pwd && ls -lah

#echo -e "${ONYELLOW} Aplicando permissões ${NORMAL}"

#chmod 777 -R .

echo -e "${ONYELLOW} get_db_vars ${NORMAL}"

get_db_vars

echo -e "${ONYELLOW} Show DB_ ${NORMAL}"

echo -e "${GREEN} MAGE_URL: ${MAGE_URL} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_HOST: ${MAGE_DB_HOST} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_PORT: ${MAGE_DB_PORT} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_NAME: ${MAGE_DB_NAME} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_USER: ${MAGE_DB_USER} ${NORMAL}"
echo -e "${GREEN} MAGE_DB_PASS: ${MAGE_DB_PASS} ${NORMAL}"

echo -e "${ONYELLOW} install.php ${NORMAL}"

php -f install.php -- \
--license_agreement_accepted "yes" \
--locale "pt_BR" \
--timezone "America/Sao_Paulo" \
--default_currency "BRL" \
--db_host "${MAGE_DB_HOST}:${MAGE_DB_PORT}" \
--db_name "${MAGE_DB_NAME}" \
--db_user "${MAGE_DB_USER}" \
--db_pass "${MAGE_DB_PASS}" \
--url "$MAGE_URL" \
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

php index.php

echo -e "${ONYELLOW} shell ${NORMAL}"

echo -e "${ONYELLOW} compiler.php --state ${NORMAL}"

php shell/compiler.php --state

echo -e "${ONYELLOW} log.php --clean ${NORMAL}"

php shell/log.php --clean

echo -e "${ONYELLOW} indexer.php --status ${NORMAL}"

php shell/indexer.php --status

echo -e "${ONYELLOW} indexer.php --info ${NORMAL}"

php shell/indexer.php --info

echo -e "${ONYELLOW} indexer.php --reindexall ${NORMAL}"

php shell/indexer.php --reindexall

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

echo -e "${ONYELLOW} n98-magerun cache:disable ${NORMAL}"

n98-magerun cache:disable --root-dir .

echo -e "${ONYELLOW} - { ${NORMAL}"

function_after

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

    #echo "${BOLD} Arguments... ${NORMAL}"
    #echo $KEY
    #echo $VALUE

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

echo -e "${ONYELLOW} .env loading in the shell ${NORMAL}"

dotenv () {
  set -a
  [ -f .env ] && . .env
  set +a
}

dotenv

echo -e "${ONYELLOW} env MAGE_ ${NORMAL}"

env | grep ^MAGE_

#

METHOD=${1}

if [ "$METHOD" ]; then
  $METHOD
else
  echo -e "${ONRED} abort () { ${NORMAL}"
fi

# 

#curl --request POST "https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg" --data $1
