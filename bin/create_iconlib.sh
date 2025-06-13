#/bin/bash

if [[ -z "$1" ]]; then
    echo "Please give the number of the miniserver as argument."
    exit
fi

UPLOAD=0
if [[ "$2" -eq "1" ]]; then
    UPLOAD=1
fi

PDATA=$(perl -e "use LoxBerry::System;print \$lbpdatadir;")
PBIN=$(perl -e "use LoxBerry::System;print \$lbpbindir;")

FULLURI=$(perl -e "use LoxBerry::System;%miniservers=LoxBerry::System::get_miniservers();print \$miniservers{$1}{FullURI};")
MSIP=$(perl -e "use LoxBerry::System;%miniservers=LoxBerry::System::get_miniservers();print \$miniservers{$1}{IPAddress};")
MSCRED=$(perl -e "use LoxBerry::System;%miniservers=LoxBerry::System::get_miniservers();print \$miniservers{$1}{Credentials};")
MSFTPPORT=$(perl -e "use LoxBerry::System; print LoxBerry::System::get_ftpport($1);")
FTPFULLURI="ftp://$MSCRED@$MSIP:$MSFTPPORT/sys/IconLibrary.zip"
REBOOTFULLURI="$FULLURI/dev/sps/restart"

if [[ -z "$MSIP" || -z "$MSCRED" || -z $MSFTPPORT ]]; then
    echo "Seems we cannot get all needed data for Miniserver No. $1."
    exit
fi

# Download IconLibrary from Miniserver
rm $PDATA/IconLibrary/IconLibrary_orig.zip
curl --output "$PDATA/IconLibrary/IconLibrary_orig.zip" "$FTPFULLURI" 
if [[ ! $(file $PDATA/IconLibrary/IconLibrary_orig.zip | grep "Zip archive data") ]]; then
    print "Seems that the downloaded IconLibrary.zip from Miniserver No. $1 is not a valid ZIP file."
    exit
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
        mv $file $i.$file
        i=$(printf "%04d\n" $(($i+1)))
    fi
done

# Create ImageLibrary
cd $PDATA
rm IconLibrary.zip
python3 $PBIN/loxicon/loxicon.py --icons "$PDATA/IconLibrary/*.svg" --library "$PDATA/IconLibrary/IconLibrary_orig.zip" --force

# Upload ImageLibrary
if [[ "$UPLOAD" -eq "1" ]]; then
    curl -T IconLibrary.zip $FTPFULLURI
    curl "$REBOOTFULLURI" 
fi
