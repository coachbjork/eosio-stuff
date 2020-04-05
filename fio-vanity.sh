#!/bin/bash

CLEOS=cleos

if [[ $1 == "" ]]; then
    echo "Search for vanity keys - Usage : ./fio-vanity.sh STRING"
    exit 1
fi

echo "Finding keys containing : $1"
STRING=$(echo "$1" | tr '[:upper:]' '[:lower:]')

while true; do
    output=$($CLEOS create key --to-console | sed 's/EOS/FIO/')
    pub=$(cut -d ' ' -f 5 <<< "${output//[$'\r\n']}")
    pub=$(echo "$pub" | tr '[:upper:]' '[:lower:]')
    if [[ $pub =~ .*$STRING.* ]]; then
      echo $output
      break
    fi
done
