#!/bin/bash

# Betik ismi: betik.sh

# Argüman kontrolü
if [ "$#" -ne 1 ]; then
    echo "Kullanım: $0 ip:port"
    exit 1
fi

SUNUCU=$1

# gamedig çıktısını JSON olarak al
JSON=$(gamedig --type css "$SUNUCU")

# Sunucu adı ve harita bilgisini göster
echo "Sunucu Adı : $(echo "$JSON" | jq -r '.name')"
echo "Harita     : $(echo "$JSON" | jq -r '.map')"

# Oyuncuları listele ve say
echo "$JSON" | jq -r '.players[] | .name' | \
awk 'BEGIN { print "\nOyuncular:" } 
     { print NR "-" $0 } 
     END { print "\nTOPLAM OYUNCU: " NR }'
