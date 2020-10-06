#!/bin/bash
echo "Enter the dir name"
read name
if [-d "$name"]
then
echo "Directory exist"
else
`mkdir $name`
echo "directory created"
fi


