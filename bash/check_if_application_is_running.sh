#!/bin/bash

# Check if gedit is running
# -x flag only match processes whose name (or command line if -f is
# specified) exactly match the pattern. 

application="spotify"


if pgrep -x $application > /dev/null
then
    echo "Running"
else
    echo "Stopped"
fi
