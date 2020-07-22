#!/bin/bash

codename=$(cat /etc/os-release | grep UBUNTU_CODENAME | cut -d = -f 2)

if [ "$codename" == "focal" ]
then
echo "processing ..."
else
echo "sorry this script is only for focal fossa"
exit 1
fi

if [ "$UID" != "0" ]
then
echo "This script must be run with sudo priveleges"
exit 1
fi

############################################################################################
case "$1" in ###############################################################################
############################################################################################
--remove)
############################################################################################

echo "
please note that we are now going to remove the splash screen 
Do you want to proceed? [y/n] Type n to exit, or press enter to proceed.
"
read answer

if [ "$answer" == "n" ] || [ "$answer" == "N" ]
then
echo "Exiting..."
exit 1
fi
sed -i 's/quiet splash//g' /etc/default/grub
sudo apt autoremove plymouth-theme-ubuntu-text -y > temp
sudo update-grub2 > temp
echo "Splash screen removed reboot to see changes"
echo "Do you want to reboot now? [y/n] .."
read lmao
if [ "$lmao" == "n" ] || [ "$lmao" == "N" ]
then
echo "Exiting..."
else
shutdown -r now
fi
;;
############################################################################################
--reset) ###################################################################################
############################################################################################
echo "
resetting back to defaults..
"
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=""/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/g' /etc/default/grub
sudo apt install plymouth-theme-ubuntu-text > temp
sudo update-grub2 > temp
echo "
				---------------
				|Reset Success|
				---------------"
;;
############################################################################################
*) #########################################################################################
############################################################################################
echo "Use the parameter '--remove' or '--reset'; example: 'sudo ./splash.sh --set' or 'sudo ./splash.sh --reset'"
exit 1
esac
