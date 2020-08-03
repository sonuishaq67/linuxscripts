#!/bin/bash

if [ "$UID" != "0" ]
then
echo "This script must be run with sudo priveleges"
exit 1
fi

touch grubimage.log
case "$1" in --set)
echo "
please note that we are now going to set the grub screen 
Do you want to proceed? [y/n] Type n to exit, or press enter to proceed.
"
read answer 

if [ "$answer" == "n" ] || [ "$answer" == "N" ]
then
echo "Exiting..."
exit 1
fi


echo "
Enter the path to the picture 
Please note that the image should be in png format or else color will not be rendered properly in the grub 
Example 1 : /home/toor/Pictures/background.png
Example 2 : ~Pictures/grub.png
"

read path
echo "GRUB_BACKGROUND="$path"" >> /etc/default/grub

sudo update-grub > grubimage.log

echo "
			       ===============
			       |             |
			       |  SUCCESSFUL |
			       |             |
			       ===============
"
;;

--reset)
echo "
please note that we are now going to reset the grub screen 
Do you want to proceed? [y/n] Type n to exit, or press enter to proceed.
"
read answer

if [ "$answer" == "n" ] || [ "$answer" == "N" ]
then
echo "Exiting..."
exit 1
fi


sed 's/GRUB_BACKGROUND/#GRUB_BACKGROUND/' /etc/default/grub >> grubimage.log
sudo update-grub > grubimage.log
echo "
                               =====================
                               |                   |
                               |  RESET SUCCESSFUL |
                               |                   |
                               =====================
"
;;
*)

echo "Use the parameter '--set' or '--reset'; example: 'sudo ./main.sh --set' or 'sudo ./main.sh --reset'"
exit 1
esac

