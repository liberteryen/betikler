#!/bin/bash

for bsp_file in *.bsp; do
    map_name="${bsp_file%.bsp}"
    res_file="${map_name}.res"

    echo "[+] İşleniyor: $bsp_file -> $res_file"

    wad_list=$(strings "$bsp_file" | grep "\.wad" | tr ';' '\n' | grep -o '[^\\/]*\.wad' | sort -u)

    for wad in $wad_list; do
        echo "$wad" >> "$res_file"
    done

    echo "    -> ${res_file} oluşturuldu"
done

echo "[✓] Tüm haritalar işlendi."
