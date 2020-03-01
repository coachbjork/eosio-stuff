#!/bin/bash
API=https://api.eossweden.org/
ACCOUNT=eosswedenorg
LIMIT=1000
AFTER=2019-01-01
BEFORE=2020-01-01
FILE=/home/coach/taxes

DATA=$(curl -X GET ""$API"v2/history/get_actions?account="$ACCOUNT"&filter=eosio.token%3Atransfer&limit="$LIMIT"&sort=desc&after="$AFTER"T00%3A00%3A01%2B00%3A00&before="$BEFORE"T00%3A00%3A01%2B00%3A00" | jq '.actions[] | {From: .act.data.from, To: .act.data.to, Amount: .act.data.amount, Date: ."@timestamp"}')
    echo "$DATA" >> "$FILE"
