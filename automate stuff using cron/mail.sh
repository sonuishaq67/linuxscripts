#!/bin/sh
 
MAILFILE=path of mail file
echo -e "Subject: Sample email @ `date`\nTo: toEmail"  
echo "\n" >> $MAILFILE
echo "Have a nice day !" >> $MAILFILE 
cat $MAILFILE | ssmtp toEmail
rm $MAILFILE
