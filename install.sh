#! /bin/bash
SRCDIR=$1
DESTINATION=$2
HEADERS=$(find $SRCDIR -name '*.h')
DIRS=$(find $SRCDIR -type d -print)

for dir in $DIRS; do
	mkdir -p ${dir/$SRCDIR/$DESTINATION}
done

for file in $HEADERS; do
	cp $file ${file/$SRCDIR/$DESTINATION}
	chmod o+r ${file/$SRCDIR/$DESTINATION}
done
