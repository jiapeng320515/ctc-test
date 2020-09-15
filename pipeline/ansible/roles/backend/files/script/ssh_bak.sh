#!/bin/bash
bak_src=$1
bak_dest=$2
echo "$bak_src"
echo "$bak_dest"
if [ -f "$bak_src" ]; then
    cp -r ${bak_src} ${bak_dest}
fi
