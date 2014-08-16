#!/bin/bash
# If django isn't running:
django_command="python /opt/josh_smith/django_god/manage.py runserver 0.0.0.0:8000"
session_name="django_god"
tmux_session_open=`tmux ls | grep -c $session_name`
django_running=`ps -ef | grep /opt/josh_smith/django_god | grep -c -v grep`

if (( $django_running==0 )); then
    echo "$session_name session not running. Checking for tmux session..."
    if (( $tmux_session_open==1 )); then
        echo "Killing previous tmux session..."
        tmux kill-session -t $session_name
    fi
    echo "Starting new tmux session $session_name:"
    tmux new-session -s $session_name -d
    tmux send-keys -t $session_name "$django_command"

else    
    if (( $tmux_session_open==0 )); then
        echo "$session_name is running but not in a session."
    else
        echo "$session_name already running in a tmux session - did not restart"
    fi
fi

