#!/bin/bash
read -p 'Which producer account?: ' PRODUCER
echo "going for ${PRODUCER}"
read -p 'How many lines to fetch? (1-250): ' LIMIT
echo "{$LIMIT} Lines it is"
read -p 'filename and location to save data?: ' FILE

# Fetch Bpay & Vpay
DATA=$(curl -s "https://api.waxsweden.org/v2/history/get_actions?account="$PRODUCER"&filter=eosio%3Adelegatebw&limit="$LIMIT"&sort=desc" | jq '.actions[] | {Account: .act.data.receiver, Date: ."@timestamp", Amount: .act.data.amount, Type: .act.data.from}')
echo "$DATA" > "$FILE"

