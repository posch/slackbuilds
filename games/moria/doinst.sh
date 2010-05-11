#!/bin/sh

config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/moria-hours.new


SCOREFILE="var/games/moria/scores"

# If the score file does not exist, create it
	if [ ! -e $SCOREFILE ]; then
		touch $SCOREFILE
		chown root:games $SCOREFILE
		chmod 664 $SCOREFILE
	fi

if [ -x usr/bin/update-desktop-database ]; then
  ./usr/bin/update-desktop-database ./usr/share/applications >/dev/null 2>&1
fi

