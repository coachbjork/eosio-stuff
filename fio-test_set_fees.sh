#!/bin/bash
CLEOS=/usr/opt/fio-mv/1.0.0/bin/clio
API=https://api.testnet.fiosweden.org/
ACCOUNT=sweidrpkehv2
PERMISSION=active

${CLEOS} -u ${API} push action fio.fee setfeevote fio-test_fees.json -p ${ACCOUNT}@${PERMISSION}