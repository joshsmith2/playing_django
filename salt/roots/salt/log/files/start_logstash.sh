#!/bin/bash
# If logstash isn't running:
logstash_command="/opt/logstash-1.4.2/bin/logstash -f /etc/logstash/logstash-sani-shipper.conf"
tmux_session_open=`tmux ls | grep -c logstash`
logstash_running=`ps -ef | grep /opt/logstash | grep -c -v grep`

if (( $logstash_running==0 )); then
    echo "Logstash session not running. Checking for tmux session..."
    if (( $tmux_session_open==1 )); then
        echo "Killing previous tmux session..."
        tmux kill-session -t logstash
    fi
    echo "Starting new tmux session 'logstash':"
    tmux new-session -s logstash -d
    tmux send-keys -t logstash "$logstash_command"

else    
    if (( $tmux_session_open==0 )); then
        echo "Logstash is running but not in a session."
    else
        echo "Logstash already running in a tmux session - did not restart"
    fi
fi

