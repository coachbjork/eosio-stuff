#!/bin/bash
# Usage:
# ./check_hyperion_doc_count.sh "2024-07-01" "2024-08-01"

AFTER=${1}
BEFORE=${2}

APILIST=("api.waxsweden.org" "wax-main.hyperion.eosrio.io" "hyperion-wax-mainnet.wecan.dev" "wax-history.eosdac.io" "wax-hyperion.eosphere.io")

echo "${AFTER} > ${BEFORE}"

for API in "${APILIST[@]}"; do
    call=$(curl -s "https://${API}/v2/history/get_actions?limit=1&track=true&sort=desc&after=${AFTER}T00%3A00%3A00.000z&before=${BEFORE}T00%3A00%3A00.000z")
    total_value=$(echo "${call}" | jq .total.value)
    echo "Total Value: ${total_value} - ${API}"
done
