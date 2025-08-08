#!/bin/bash

timestamp=$(date +%s)    # örnek olarak şu anki zaman damgası
token="SENIN_TOKENIN_BURAYA"


curl -X POST "http://localhost:8008/_synapse/admin/v1/purge_media_cache?before_ts=${timestamp}" \
  -H "Authorization: Bearer ${token}" \
  -H "Content-Type: application/json" \
  -d '{}'
