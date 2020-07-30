install mailutils
```sudo apt install mailutils```
edit the file
```sudo vim /etc/ssmtp/ssmtp.conf```
with credentials in the below format
```
root=your-email@gmail.com

# The place where the mail goes. The actual machine name is required no 
# MX records are consulted. Commonly mailhosts are named mail.domain.com
mailhub=smtp.gmail.com:587 # for gmail
AuthUser=mail-username
AuthPass=mail-password
UseSTARTTLS=YES
UseTLS=YES
mailhub=smtp.gmail.com:587 # for gmail
```
edit crontab file using crontab -e//executes every hour at 00 minutes eg 4:00 5:00
```
00 * * * * /path/to/mail.sh  
```

