#!/usr/bin/env bash

echo "Welcome to the True or False Game!"
<<comment
$var1 = "Login message: "
curl --silent --output ID_card.txt http://127.0.0.1:8000/download/file.txt
var=$(cat ID_card.txt | cut -d \" -f4,8 | tr \" :)
curl --silent --output cookie.txt --cookie-jar cookie --user $var http://127.0.0.1:8000/login
echo "Login message: " && cat cookie.txt
curl --silent --output out.txt --cookie cookie http://127.0.0.1:8000/game
echo "Response: " && cat out.txt
comment
echo "0. Exit"
echo "1. Play a game"
echo "2. Display scores"
echo "3. Reset scores"
echo "Enter an option:"
read con
while [ $con != 0 ]
do
    if [ $con -eq 1 ]
    then
        echo "Playing game"
    elif [ $con -eq 2 ]
    then
        echo "Displaying scores"
    elif [ $con -eq 3 ]
    then
        echo "Resetting scores"
    else
        echo "Invalid option!"
    fi
    echo "0. Exit"
    echo "1. Play a game"
    echo "2. Display scores"
    echo "3. Reset scores"
    echo "Enter an option:"
    read con
done
echo "See you later!"
