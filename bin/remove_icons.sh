#!/bin/bash

# Vars
PDATA=$(perl -e "use LoxBerry::System;print \$lbpdatadir;")
PBIN=$(perl -e "use LoxBerry::System;print \$lbpbindir;")
PNAME=$(perl -e "use LoxBerry::System;print \$lbpplugindir;")

# Logging
. $LBHOMEDIR/libs/bashlib/loxberry_log.sh
cleanlog() {
    LOGEND "Bye."
}
trap cleanlog EXIT
PACKAGE=$PNAME
NAME=$0
FILENAME=${LBPLOG}/${PACKAGE}/$0.log
STDERR=1

LOGSTART "$0 started."

# Index filenames
mkdir -p $PDATA/IconLibrary
cd $PDATA/IconLibrary
i=1
for file in *.svg; do
    prefix=$(echo $file | cut -d. -f 1)
    re='^[0-9]+$'
    if [[ $prefix =~ $re ]] ; then
        if [[ "$prefix" -gt "8999" ]]; then
            LOGINF "Removing $file"
            rm $file
        fi
    fi
done

exit 0
