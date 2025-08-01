#!/bin/bash

# Temizlenecek dosya uzantıları (büyük/küçük harfe duyarsız)
extensions="jpg jpeg png gif tiff bmp webp heic heif"

# IFS ayarla (Internal Field Separator) ve globstar ile tüm alt dizinlerde ara
shopt -s globstar nocaseglob nullglob

for ext in $extensions; do
  for file in ./**/*.${ext}; do
    if [[ -f "$file" ]]; then
      echo "Temizleniyor: $file"
      exiftool -overwrite_original -all= "$file"
    fi
  done
done
