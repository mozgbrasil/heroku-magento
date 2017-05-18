#!/bin/bash

#

echo -e "--(-)--"

pwd

echo -e "--(-)--"

ls

echo -e "--(-)--"

echo $1

echo -e "--(-)--"

curl --request POST "https://fleep.io/hook/OLuIRi0JRt2yv5OQisX6tg" --data $1

echo -e "--(-)--"

#