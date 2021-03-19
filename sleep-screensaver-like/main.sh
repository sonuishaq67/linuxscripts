#!/bin/zsh

export PATH="/home/toor/.gem/ruby/2.7.0/bin:/home/toor/.npm-global/bin:/home/toor/.scripts:/home/toor/.npm-global/lib/node_modules/@angular/cli/bin:/home/toor/.local/bin:/home/toor/go/bin:/home/toor/flutter/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/opt/android-sdk/tools:/opt/android-sdk/tools/bin:/usr/lib/emscripten:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/plan9/bin:/home/toor/.pub-cache/bin"


IDLE_TIME=$((1 * 60 * 1000))

trigger_cmd() {
    IS_ALREADY_RUNNING=$(/usr/bin/pgrep cmatrix >/dev/null && echo Running)
    if [ "$IS_ALREADY_RUNNING" -eq "Running" ]; then
        echo "nothing"
    else
        export DISPLAY=":0"
        /usr/bin/gnome-terminal --full-screen -e "/usr/bin/cmatrix"
    fi
}

sleep_time=$IDLE_TIME
triggered=false

while sleep $(((sleep_time + 999) / 1000)); do
    idle=$(xprintidle)
    echo $idle
    echo $IDLE_TIME
    if [ $idle -gt $IDLE_TIME ]; then
        if ! $triggered; then
            trigger_cmd
            triggered=true
            sleep_time=$IDLE_TIME
        fi
    else
        triggered=false
        sleep_time=$((IDLE_TIME - idle + 100))
    fi
done
