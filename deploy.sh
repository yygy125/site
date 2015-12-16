#!/bin/bash
# easywechat.org builder.
# @author overtrue <anzhengchao@gmail.com>

travis login --org --github-token=${GH_TOKEN}
TOKEN=$(travis token | awk -F 'is' '{print $1}')

body='{
"request": {
    "message": "Update docs (triggered by easywechat/docs).",
    "branch":"master"
  }
}'

curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "Travis-API-Version: 3" \
  -H "Authorization: token ${TOKEN}" \
  -d "$body" \
  https://api.travis-ci.org/repo/EasyWeChat%2Fsite/requests