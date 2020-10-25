## Install [espeak](https://www.vultr.com/docs/install-espeak-on-ubuntu-18-04) package 
```sh
sudo apt-get install espeak
```
## Install [zenity](https://zoomadmin.com/HowToInstall/UbuntuPackage/zenity) package 
```sh
sudo apt-get install -y zenity
```

## Now edit in crontab -e
```sh
 */30 * * * * cd /home/toor/scripts/battery-low-full/ && ./main.sh 
```