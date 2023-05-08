#!/usr/bin/env bash

echo "Welcome to the True or False Game!"
curl --silent --output ID_card.txt http://127.0.0.1:8000/download/file.txt
cat ID_card.txt
