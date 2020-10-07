#!/bin/bash

read -p "Hello there, do you want to view the current shopping list? y/n " answer

if [ $answer == "y" ]
then
    cat list-of-names.txt
fi

read -p "what do you want to add to the shopping list? " food

echo "I will add $food to the shopping list shortly..." 

sleep 2

echo $food >> list-of-names.txt

cat list-of-names.txt