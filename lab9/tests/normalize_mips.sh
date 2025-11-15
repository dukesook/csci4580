#!/usr/bin/env bash

file="$1"

sed 's/#.*$//' "$file"                    | # strip comments
sed 's/,//g'                              | # REMOVE COMMAS TODO: fix scooper
sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | # trim both ends
sed '/^$/d'                               | # drop blank lines
tr -s ' '                                   # collapse multiple spaces to one
