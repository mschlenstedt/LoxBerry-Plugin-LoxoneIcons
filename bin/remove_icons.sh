#/bin/bash

PDATA=$(perl -e "use LoxBerry::System;print \$lbpdatadir;")
PBIN=$(perl -e "use LoxBerry::System;print \$lbpbindir;")

# Index filenames
mkdir -p $PDATA/IconLibrary
cd $PDATA/IconLibrary
i=1
for file in *.svg; do
    prefix=$(echo $file | cut -d. -f 1)
    re='^[0-9]+$'
    if [[ $prefix =~ $re ]] ; then
        if [[ "$prefix" -gt "8999" ]]; then
            rm $file
        fi
    fi
done

