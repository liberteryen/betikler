#!/bin/bash


SERVER_URL="http://localhost:8008"
ACCESS_TOKEN=""


TIMESTAMP=$(date +%s%3N)

# Tüm odaları çek (yalnızca room_id’leri alıyoruz)
room_ids=$(curl -s -H "Authorization: Bearer $ACCESS_TOKEN" "$SERVER_URL/_synapse/admin/v1/rooms" \
  | jq -r '.rooms[].room_id')

# Her bir oda için purge_history isteği gönder
for room_id in $room_ids; do
  echo "Siliniyor: $room_id"
  
  curl -s -X POST "$SERVER_URL/_synapse/admin/v1/purge_history/$room_id" \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"purge_up_to_ts\": $TIMESTAMP}"
  
  echo ""
done
