#!/bin/bash
# Add to account list to add multiple accounts.
# Script will create file with date+account name.
# Edit After and Before to change date range.
# If you have a lot of tx, you need to shorten the time between dates.

API=https://api.eossweden.org/
ACCOUNTS=(eosriobrazil eosswedenorg)
LIMIT=1000
AFTER=2019-01-01
BEFORE=2020-01-01
DATE=$(date +%F)

for value in "${ACCOUNTS[@]}"
    do
    DATA=$(curl -X GET ""$API"v2/history/get_actions?account="${value}"&filter=eosio.token%3Atransfer&limit="$LIMIT"&sort=desc&after="$AFTER"T00%3A00%3A01%2B00%3A00&before="$BEFORE"T00%3A00%3A01%2B00%3A00" | jq '.actions[] | {From: .act.data.from, To: .act.data.to, Amount: .act.data.amount, Token: .act.data.symbol, Date: ."@timestamp"}')
    echo "$DATA" > "$DATE ${value}"
done
