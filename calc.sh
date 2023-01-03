#!/bin/bash

Version=$(git describe --tags | cut -d '-' -f1 | awk -F. -v OFS=. '{$NF += 1 ; print }')

if [ "$Version" = ""];then
Version="$1.1"
if
echo $Version