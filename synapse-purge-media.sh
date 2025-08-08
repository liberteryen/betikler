#!/bin/bash

timestamp=$(date -d "+1 day" +%s%3N)
token="SENIN_TOKENIN_BURAYA"


curl -X POST "http://localhost:8008/_synapse/admin/v1/purge_media_cache?before_ts=${timestamp}" \
  -H "Authorization: Bearer ${token}" \
  -H "Content-Type: application/json" \
  -d '{}'
