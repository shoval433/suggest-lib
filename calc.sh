#!/bin/bash

Version=$(git describe --tags | cut -d '-' -f1 | awk -F. -v OFS=. '{$NF += 1 ; print }')

if [ "${Version}" = "" ];then
Version="$1.1"
fi
Version_Test=$(echo $Version | cut -d '.' -f1-2)
if [ "${Version_Test}" != "${Version}" ];then
Version="$1.1"
fi


echo $Version