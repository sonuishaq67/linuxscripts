#!/bin/bash

# to check every 15 minutes for a new version in git

MAILFILE=~/TARS/mail.log
git pull &>.pull
stop_process() {
    process_id=$(ps -ef | grep "bot.py" | cut -b 12-16 | head -n 1)
    kill -9 $process_id
}

run_again() {
    cd ~/TARS
    rm nohup.out
    nohup ./bot.py &
}

send_mail() {
    cat ~/TARS/.pull >>$MAILFILE
    cat $MAILFILE | /usr/sbin/ssmtp yourmail@mail.com
}
c1=$(cat .pull | grep "up to date" | wc -l)
c2=$(cat .pull | grep "insertion" | wc -l)
c3=$(cat .pull | grep "Aborting" | wc -l)
if [ "$c1" -gt 0 ]; then
    echo "already upto date"
    exit
elif [ "$c2" -gt 0 ]; then
    echo "updating"
    stop_process
    run_again
    echo -e "Subject: Rerun code @ $(date)\nTo: mail@gmail.com" >$MAILFILE
    send_mail
elif [ "$c3" -gt 0 ]; then
    echo "error"
    echo -e "Subject: Theres a pulling error for repo @ $(date)\nTo: mail@gmail.com" >$MAILFILE
    send_mail
fi
