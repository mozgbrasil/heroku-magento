#!/bin/bash

#

echo -e "--(22/05/2017 12:57:54)--"

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