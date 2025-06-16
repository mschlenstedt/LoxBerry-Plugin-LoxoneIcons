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

FULLURI=$(perl -e "use LoxBerry::System;%miniservers=LoxBerry::System::get_miniservers();print \$miniservers{$1}{FullURI};")
MSIP=$(perl -e "use LoxBerry::System;%miniservers=LoxBerry::System::get_miniservers();print \$miniservers{$1}{IPAddress};")
MSCRED=$(perl -e "use LoxBerry::System;%miniservers=LoxBerry::System::get_miniservers();print \$miniservers{$1}{Credentials};")
MSFTPPORT=$(perl -e "use LoxBerry::System; print LoxBerry::System::get_ftpport($1);")
FTPFULLURI="ftp://$MSCRED@$MSIP:$MSFTPPORT/sys/IconLibrary.zip"
REBOOTFULLURI="$FULLURI/dev/sps/restart"

# Check if ms is configured
if [[ -z "$MSIP" || -z "$MSCRED" || -z $MSFTPPORT ]]; then
    LOGERR "Seems we cannot get all needed data for Miniserver No. $1."
    exit 1
fi

# Download IconLibrary from Miniserver
rm $PDATA/IconLibrary_orig.zip
curl --output "$PDATA/IconLibrary_orig.zip" "$FTPFULLURI" >> ${FILENAME} 2>&1
if [[ $? -ne 0 ]]; then
    LOGERR "Download of Icon Library from Miniserver No. $1 failed."
    exit 1
else
    LOGOK "Download of Icon Library from Miniserver No. $1 finished."
fi
if [[ ! $(file $PDATA/IconLibrary_orig.zip | grep "Zip archive data") ]]; then
    LOGERR "Seems that the downloaded IconLibrary.zip from Miniserver No. $1 is not a valid ZIP file."
    exit 1
fi
#curl -I "$FULLURI" | grep "Last-Modified:" > $1_server_modified

# Index filenames
mkdir -p $PDATA/IconLibrary
cd $PDATA/IconLibrary
i=1
for file in *.svg; do
    prefix=$(echo $file | cut -d. -f 1)
    re='^[0-9]+$'
    if [[ $prefix =~ $re ]] ; then
        if [[ "$prefix" -gt "$i" && "$prefix" -lt "9000" ]]; then
            i=$prefix
        fi
    fi
done
i=$(printf "%04d\n" $(($i+1)))

# Rename un-indexed files
for file in *.svg; do
    prefix=$(echo $file | cut -d. -f 1)
    re='^[0-9]+$'
    if [[ ! $prefix =~ $re ]] ; then
        LOGINF "Renaming $file to $i.$file"
        mv $file $i.$file
        i=$(printf "%04d\n" $(($i+1)))
    fi
done

# Create ImageLibrary
cd $PDATA
rm IconLibrary.zip
python3 $PBIN/loxicon/loxicon.py --icons "$PDATA/IconLibrary/*.svg" --library "$PDATA/IconLibrary_orig.zip" --force >> ${FILENAME} 2>&1
if [[ $? -ne 0 ]]; then
    LOGERR "Creating of Icon Library failed."
    rm IconLibrary_orig.zip
    exit 1
else
    LOGOK "Creating of Icon Library finished."
    rm IconLibrary_orig.zip
    exit 0
fi

exit 0
