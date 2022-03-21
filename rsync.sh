#!/bin/sh
# Use -n to perform a dry run.
# This is a simple script I use to Rsync between my desktop and laptop.

DIRS="Documents Pictures .utils "
CONFIG="~/.config"
RECEIVER="laptop" #Name of device in /etc/hosts or IP.

# Sync the main dirs
rsync -uavrP --bwlimit=4000 --no-relative --delete-after $DIRS $RECEIVER: 
if [[ $? -eq 0 ]]; then
	notify-send "Main Directory sync complete."
else
	notify-send "Sync Error"
fi
# Config and other dirs
rsync -uavrP --bwlimit=4000 --no-relative --delete-after $CONFIG/vim $CONFIG/i3 $RECEIVER:
if [[ $? -eq 0 ]]; then
	notify-send "Config Directory sync complete."
else
	notify-send "Sync Error"
fi
