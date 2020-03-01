#!/bin/bash
# You can change the API if you want.
# By adding a comment the output will go to that file, i.ex. "./get_taxes.sh filename"
# You can easily edit the before and after dates
# If you don't get enough transactions, you need to shorten the time between dates.

API=https://api.eossweden.org/
ACCOUNT=eosswedenorg
LIMIT=1000
AFTER=2019-01-01
BEFORE=2020-01-01
FILE="$@"

DATA=$(curl -X GET ""$API"v2/history/get_actions?account="$ACCOUNT"&filter=eosio.token%3Atransfer&limit="$LIMIT"&sort=desc&after="$AFTER"T00%3A00%3A01%2B00%3A00&before="$BEFORE"T00%3A00%3A01%2B00%3A00" | jq '.actions[] | {From: .act.data.from, To: .act.data.to, Amount: .act.data.amount, Token: .act.data.symbol, Date: ."@timestamp"}')
    echo "$DATA" >> "$FILE"
