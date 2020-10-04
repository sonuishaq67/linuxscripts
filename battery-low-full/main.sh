#!/bin/bash 

battery_level=$(acpi -b |cut -d "," -f2| sed 's/%//g') 

echo $battery_level			 
ac_power=$(acpi -b|grep -c "Charging") 
echo $ac_power	
if [[ $ac_power -eq 1 && $battery_level -eq 100 ]] #if charging and battery_level==100 
then
export DISPLAY=:0.0 
zenity --warning --title="Battery level $battery_level" --width=600 --timeout=10 --text="Please remove the charger" | espeak "Charge full, Please Remove the charger" -s 140 
fi

if [[ $ac_power -eq 0 && $battery_level -lt 20 ]] 
then
export DISPLAY=:0.0 
zenity --warning --title="Battery level $battery_level" --width=600 --timeout=10 --text="Please plug the charger" | espeak "Please connect the charger" -s 140 
fi
