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

# COmmandline ARGs
if [[ -z "$1" ]]; then
    LOGERR "Please give the number of the miniserver as argument."
    exit 1
fi

# Vars
FULLURI=$(perl -e "use LoxBerry::System;%miniservers=LoxBerry::System::get_miniservers();print \$miniservers{$1}{FullURI};")
MSIP=$(perl -e "use LoxBerry::System;%miniservers=LoxBerry::System::get_miniservers();print \$miniservers{$1}{IPAddress};")
MSCRED=$(perl -e "use LoxBerry::System;%miniservers=LoxBerry::System::get_miniservers();print \$miniservers{$1}{Credentials};")
MSFTPPORT=$(perl -e "use LoxBerry::System; print LoxBerry::System::get_ftpport($1);")
FTPFULLURI="ftp://$MSCRED@$MSIP:$MSFTPPORT/sys/IconLibrary.zip"
REBOOTFULLURI="$FULLURI/dev/sps/restart"

# Upload ImageLibrary
cd $PDATA
curl -T IconLibrary.zip $FTPFULLURI >> ${FILENAME} 2>&1
if [[ $? -ne 0 ]]; then
    LOGERR "Upload of Icon Library to Miniserver No. $1 failed."
    exit 1
else
    LOGOK "Upload of Icon Library to Miniserver No. $1 finished. Rebooting Miniserver."
    curl "$REBOOTFULLURI" >> ${FILENAME} 2>&1
    exit 0
fi

exit 0
