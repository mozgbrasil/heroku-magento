#!/usr/bin/env bash

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

GIT=`which git` > /dev/null
PHP_BIN=`which php`
OS=`uname -s`
REV=`uname -r`
MACH=`uname -m`
BASE_PATH_USER=~

# Define text styles
BOLD=`tput bold`
NORMAL=`tput sgr0`

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

show_help () {
    echo "${BOLD} MOZG BASH SHELL SCRIPT ${NORMAL}"
    echo
    echo "Usage: bash app.sh [COMMAND]"
    echo
    echo "  clone                            Clone repositories"
    echo "  publish                          Publish repositories"
    echo
}

#

#

METHOD=${1}

#

# Parse the command line arguments
if [ "$METHOD" ]; then
	$METHOD 
else
	show_help
fi

exit



#

args=("$@") # store arguments in a special array 
ELEMENTS=${#args[@]} # get number of elements 
for (( i=0;i<$ELEMENTS;i++)); do 
	TMP=${args[${i}]}
	#echo ${i}st argument: $TMP
done

METHOD=${1}
echo $METHOD






exit

#

echo -e "--(1)--"

pwd

echo -e "--(2)--"

ls

echo -e "--(3)--"

echo $1

echo -e "--(4)--"

curl --request POST "https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg" --data $1

echo -e "--(5)--"

#