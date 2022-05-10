import re
import requests
import json
from math import fsum

def get_data(url) :
    try :
        resp = requests.get(url)
        if resp.status_code == 200 :
            return resp.json()
    except requests.exceptions.RequestException as e:
        pass
    return {}

def api_coingecko(coins) :
    url = "https://api.coingecko.com/api/v3/simple/price?ids=wax&vs_currencies=%s" % (','.join(coins))
    data = get_data(url)
    if "wax" in data :
        return { k.upper(): v for k,v in data["wax"].items() }
    return data

def api_cryptocompare(coins) :
    url = "https://min-api.cryptocompare.com/data/price?fsym=WAX&tsyms=%s" % (','.join(coins))
    return get_data(url)

coins = [ 'BTC', 'USD', 'ETH', 'EOS' ]


# Init results dict
results = { k: [] for k in coins }
# Try fetching prices.

for k,v in api_coingecko(coins).items() :
    results[k].append(v)

for k,v in api_cryptocompare(coins).items() :
    results[k].append(v)

# Calculate avarage price.
results = { k: (fsum(v) / len(v)) for k,v in results.items() }

# Hack to get rid of the stupid sientific notation bullshit.
results = json.dumps(results, separators=(',', ':'))
print(re.sub('\"([0-9]+\.[0-9]+)\"', '\\1', results))
