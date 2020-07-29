#!/bin/bash

codename=$(cat /etc/os-release | grep UBUNTU_CODENAME | cut -d = -f 2)

if [ "$codename" == "focal" ]
then
source="/usr/share/gnome-shell/theme/Yaru/gnome-shell-theme.gresource"
else
echo "
----------------------------------------
Sorry, Script is only for Ubuntu 20.04
Exiting...
----------------------------------------"
exit 1
fi

pkg=$(dpkg -l | grep libglib2.0-dev >/dev/null && echo "yes" || echo "no")
if [ "$pkg" == "no" ]
then
echo "
-----------------------------------------------------------------------------------------------------
the package 'libglib2.0-dev' is not installed.Hence installing it
-----------------------------------------------------------------------------------------------------"
sudo apt-get install libglib2.0-dev -y > temp
fi


case "$1" in --set)

if [ "$UID" != "0" ]
then
echo "This script must be run with sudo priveleges"
exit 1
fi

echo "
-------------------------------------------------------------------------------------------------------
Please note that after setting login screen background,
You have to restart your device especially if you're running this script for the first time.

==========>If it's not the first time you're running this a logout will be enough<==========

Do you want to proceed now? [y/n] Type n to exit, or press enter to proceed.
-------------------------------------------------------------------------------------------------------"
read answer

if [ "$answer" == "n" ] || [ "$answer" == "N" ]
then
echo "Exiting..."
exit 1
fi

echo "
Choose one of the options from below 
-----------------------------------------
1.Image		2.Color
-----------------------------------------"
read a

if [ -z $a ]
then
echo "Option is not selected.
Exiting..."
exit 1
fi

if [ "$a" == "1" ]
then
echo "Enter Image Path for Login Screen
------------------------------------------------------------------
Example1: /usr/share/backgrounds/Focal-Fossa_WP_4096x2304_GREY.png
Example2: /home/focal/Downloads/images.jpg
----------------------------------------------------"
read b

elif [ "$a" == "2" ]
then
echo "
Enter Hex Color Code for Login Screen (you may note down colors of your choice from this link https://www.color-hex.com/)
-------------------------------------------------------------------------------------------------------------------------
Example1: #000000
Example2: #252525
Example3: #123456
Example4: #AAAAAA
Example5: #AC7A8A
-------------------------------------------------------------------------------------------------------------------------"
read c
fi

if [ -z $b ] && [ -z $c ]
then
echo "Input is not Provided.
Exiting..."
exit 1
fi

if [ -z $c ]
then
color="#042320"
else
color="$c"
fi

if ! [ -z $c ]
then
    	if ! [[ $c =~ ^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$ ]]; then
    	echo "
------------------------------------------------------------------------------------------------------------
    	Sorry the given hex code is not valid try choosing one from herehttps://www.color-hex.com/
------------------------------------------------------------------------------------------------------------"
    	exit 1
    	fi
fi

if ! [ -z $b ]
then
	if ! [ -e $b ]; then
	echo "
---------------------------------------------------------------------------------------------------
The image path you entered does not exist script defined background is going to bve used for now .
---------------------------------------------------------------------------------------------------"
	fi
fi

prefix="/org/gnome/shell/theme"
dest="/usr/local/share/gnome-shell/theme/focalgdm3"

install -D /dev/null $dest/gdm3.css
install -D /dev/null $dest/focalgdm3.gresource.xml
install -d $dest/icons/scalable/actions

gresource extract $source $prefix/gdm3.css > $dest/original.css
gresource extract $source $prefix/checkbox.svg > $dest/checkbox.svg
gresource extract $source $prefix/checkbox-off.svg > $dest/checkbox-off.svg
gresource extract $source $prefix/checkbox-focused.svg > $dest/checkbox-focused.svg
gresource extract $source $prefix/checkbox-off-focused.svg > $dest/checkbox-off-focused.svg
gresource extract $source $prefix/toggle-on.svg > $dest/toggle-on.svg
gresource extract $source $prefix/toggle-off.svg > $dest/toggle-off.svg
gresource extract $source $prefix/icons/scalable/actions/pointer-drag-symbolic.svg > $dest/icons/scalable/actions/pointer-drag-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/keyboard-enter-symbolic.svg > $dest/icons/scalable/actions/keyboard-enter-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/keyboard-hide-symbolic.svg > $dest/icons/scalable/actions/keyboard-hide-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/pointer-secondary-click-symbolic.svg > $dest/icons/scalable/actions/pointer-secondary-click-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/keyboard-shift-filled-symbolic.svg > $dest/icons/scalable/actions/keyboard-shift-filled-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/keyboard-caps-lock-filled-symbolic.svg > $dest/icons/scalable/actions/keyboard-caps-lock-filled-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/pointer-primary-click-symbolic.svg > $dest/icons/scalable/actions/pointer-primary-click-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/keyboard-layout-filled-symbolic.svg > $dest/icons/scalable/actions/keyboard-layout-filled-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/eye-not-looking-symbolic.svg > $dest/icons/scalable/actions/eye-not-looking-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/pointer-double-click-symbolic.svg > $dest/icons/scalable/actions/pointer-double-click-symbolic.svg
gresource extract $source $prefix/icons/scalable/actions/eye-open-negative-filled-symbolic.svg > $dest/icons/scalable/actions/eye-open-negative-filled-symbolic.svg

echo '@import url("resource:///org/gnome/shell/theme/original.css");
  #lockDialogGroup {
  background: '$color' url(file://'$b');
  background-repeat: no-repeat;
  background-size: cover;;
  background-position: center; }' > $dest/gdm3.css

echo '<?xml version="1.0" encoding="UTF-8"?>
<gresources>
  <gresource prefix="/org/gnome/shell/theme">
    <file>original.css</file>
    <file>gdm3.css</file>
    <file>toggle-off.svg</file>
    <file>checkbox-off.svg</file>
    <file>toggle-on.svg</file>
    <file>checkbox-off-focused.svg</file>
    <file>checkbox-focused.svg</file>
    <file>checkbox.svg</file>
    <file>icons/scalable/actions/pointer-drag-symbolic.svg</file>
    <file>icons/scalable/actions/keyboard-enter-symbolic.svg</file>
    <file>icons/scalable/actions/keyboard-hide-symbolic.svg</file>
    <file>icons/scalable/actions/pointer-secondary-click-symbolic.svg</file>
    <file>icons/scalable/actions/keyboard-shift-filled-symbolic.svg</file>
    <file>icons/scalable/actions/keyboard-caps-lock-filled-symbolic.svg</file>
    <file>icons/scalable/actions/pointer-primary-click-symbolic.svg</file>
    <file>icons/scalable/actions/keyboard-layout-filled-symbolic.svg</file>
    <file>icons/scalable/actions/eye-not-looking-symbolic.svg</file>
    <file>icons/scalable/actions/pointer-double-click-symbolic.svg</file>
    <file>icons/scalable/actions/eye-open-negative-filled-symbolic.svg</file>
  </gresource>
</gresources>' > $dest/focalgdm3.gresource.xml

cd $dest
glib-compile-resources focalgdm3.gresource.xml
mv focalgdm3.gresource ..
rm -r $dest
update-alternatives --quiet --install /usr/share/gnome-shell/gdm3-theme.gresource gdm3-theme.gresource /usr/local/share/gnome-shell/theme/focalgdm3.gresource 0
update-alternatives --quiet --set gdm3-theme.gresource /usr/local/share/gnome-shell/theme/focalgdm3.gresource

check=$(update-alternatives --query gdm3-theme.gresource | grep Value | grep /usr/local/share/gnome-shell/theme/focalgdm3.gresource >/dev/null && echo "pass" || echo "fail")
if [ "$check" == "pass" ]
then
echo "
				     		---------
						|Success|
						---------"
else
echo Failure
exit 1
fi
;;

--reset)

if [ -e /usr/local/share/gnome-shell/theme/focalgdm3.gresource ]
then
rm /usr/local/share/gnome-shell/theme/focalgdm3.gresource
update-alternatives --quiet --set gdm3-theme.gresource "$source"
cd /usr/local/share
rmdir --ignore-fail-on-non-empty -p gnome-shell/theme
echo "
					        ---------------
						|Reset Success|
						---------------"
else
echo "
-----------------------------------------------------------------------------
Script background is already reset or likely the script was never used
-----------------------------------------------------------------------------"
exit 1
fi
;;
*) 
echo "Use the parameter '--set' or '--reset'; example: 'focal.sh --set' or 'focal.sh --reset'"
exit 1
esac
