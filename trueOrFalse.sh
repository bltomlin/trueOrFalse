#!/usr/bin/env bash

echo "Welcome to the True or False Game!"
curl --silent --output ID_card.txt http://127.0.0.1:8000/download/file.txt
var=$(cat ID_card.txt | cut -d \" -f4,8 | tr \" :)
curl --silent --output cookie.txt --cookie-jar cookie --user $var http://127.0.0.1:8000/login
echo "Login message: " && cat cookie.txt
