#!/bin/bash

USERNAME=""
PER_PAGE=100
PAGE=1

echo "Kullanıcı: $USERNAME"
echo "Gist'ler indiriliyor..."

while true; do
    echo "📄 Sayfa $PAGE"
    RESPONSE=$(curl -s "https://api.github.com/users/$USERNAME/gists?per_page=$PER_PAGE&page=$PAGE")

    # Hata veya sınır kontrolü
    if ! echo "$RESPONSE" | jq -e 'type == "array"' > /dev/null; then
        echo "❌ API yanıtı geçersiz. Rate limit'e takılmış olabilir misiniz?"
        echo "$RESPONSE"
        break
    fi

    COUNT=$(echo "$RESPONSE" | jq 'length')
    if [ "$COUNT" -eq 0 ]; then
        echo "✅ Tüm Gist'ler indirildi."
        break
    fi

    # Gist'lerdeki tüm dosyaları indir
    echo "$RESPONSE" | jq -r '
        .[] | 
        .files | to_entries[] | 
        [.value.filename, .value.raw_url] | @tsv
    ' | while IFS=$'\t' read -r FILENAME RAW_URL; do
        echo "⬇️  $FILENAME"
        curl -sL "$RAW_URL" -o "$FILENAME"
    done

    PAGE=$((PAGE + 1))
done
