import os
import urllib.request

TIMEOUT = 10  # seconds


def lambda_handler(event, context):
    url = os.environ['base_url']
    try:
        response = urllib.request.urlopen(url, timeout=TIMEOUT)
        if response.getcode() != 200:
            raise Exception("HTTP status {code}".format(code=response.getcode()))
    except Exception as e:
        raise Exception("The {url} url is not working properly: {e}".format(url=url, e=e))
