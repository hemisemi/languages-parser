#! /bin/bash
SRCDIR=$1
DESTINATION=$2
HEADERS=$(find $SRCDIR -name '*.h')
DIRS=($(find $SRCDIR -type d -print))

for file in $HEADERS; do
	rm -f ${file/$SRCDIR/$DESTINATION}
done

for ((i=${#DIRS[@]} - 1; i >= 0; i--)); do
	dir=${DIRS[i]}
	idir=${dir/$SRCDIR/$DESTINATION}
	if [ -d $idir ]; then # exits ?
		if [ "$(ls -A $idir)" ]; then # not empty ?
			echo "$idir not removed (not empty)"
		else
			echo "removing $idir"
			rm -rf $idir
		fi
	fi
done
