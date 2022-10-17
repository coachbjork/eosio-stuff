#!/usr/bin/python3
import requests

api = 'https://api.fiosweden.org'
proposer = 'lion4uxxfbqo'

def get_producers():
    url = f"{api}/v1/chain/get_producers"
    payload = {"limit":30,
                "lower_bound":"",
                "json":"true"}
    response = requests.post(url,json=payload,timeout=10).json()
    producer_accounts = {}
    i = 1
    for row in response["producers"]:
        bp_acc = row['owner']
        bp_readable = row['fio_address']
        bp_readable_fixd = bp_readable.split("@")
        producer_accounts.update({bp_acc:bp_readable_fixd[1]})
        if i < 10:
            delimiter = "  | "
        else:
            delimiter = " | "
        print(i,delimiter,row['owner']," | ",row['fio_address'])
        i += 1
    return producer_accounts

def check_msig():
    url = f"{api}/v1/chain/get_table_rows"
    payload = {
            "code": "eosio.msig",
            "table": "approvals2",
            "scope": proposer,
            "index_position": "",
            "key_type": "",
            "encode_type": "",
            "upper_bound": "",
            "lower_bound": "",
            "json":"true"
            }
    response = requests.post(url,json=payload,timeout=10).json()
    i = 1
    prod_dick = get_producers()
    for row in response["rows"]:
        proposal_name = row['proposal_name']
        signed_count = len(row['provided_approvals'])
        bps_signed = []
        for rows in row['provided_approvals']:
            lvl = rows['level']
            bp_acc = lvl['actor']
            bps_signed.append(prod_dick[bp_acc])
        print(proposal_name,' | ',signed_count,' Signed', bps_signed)
        i += 1

check_msig()