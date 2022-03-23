#!/bin/sh
# Use -n to perform a dry run of rsync.

cd
DIRS="Documents Pictures .utils"
CONFIG=".config"
declare -i e=0
DEST="arch" #name from /etc/hosts or local IP address.

# Sync the main directories
rsync -uavrP --bwlimit=4000 --no-relative --delete-after /home/ross/$DIRS $DEST: 
while [[ $? -gt 0 ]]; do
	e=$((e+1)) # Produces an error code if the rsync line produces an error.
	echo "Error"
done

# Config and misc directories
rsync -uavrP --bwlimit=4000 --no-relative --delete-after $CONFIG/vim $CONFIG/i3 $DEST:~/.config
while [[ $? -gt 0 ]]; do
	e=$((e+1))
	echo "Error."
done
# Aiming to do both of these in the same loop down the road.

echo "$e"
if [["$e" -gt 0]]; then # If errors codes are more than 0, there was an error somewhere.
	notify-send "There were error(s) with sync."
else
	notify-send "Sync successful."
fi
cd -
