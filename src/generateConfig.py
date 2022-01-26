import json
def generate(port, api_token, push_token):
    with open('/home/phablet/.cache/bla.xys/config.json', mode='w', encoding='utf8') as f:
        data = {
                "push_app": "bla.xys_main",
                "api_token": api_token,
                "push_token": push_token,
                "api_port": int(port)
            }
        json.dump(data, f)
