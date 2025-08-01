#!/bin/bash

# URL listesi
URLS=(
  "https://mirrors.uni-plovdiv.net/archlinux/iso/2025.06.01/archlinux-2025.06.01-x86_64.iso"
  "https://mirrors.pablonara.com/archlinux/iso/2025.06.01/archlinux-2025.06.01-x86_64.iso"
  "https://mirrors.jlu.edu.cn/archlinux/iso/2025.06.01/archlinux-2025.06.01-x86_64.iso"
  "https://mirrors.hust.edu.cn/archlinux/iso/2025.06.01/archlinux-2025.06.01-x86_64.iso"
  "https://f.matthieul.dev/mirror/archlinux/iso/2025.06.01/archlinux-2025.06.01-x86_64.iso"
  "https://ftp.linux.org.tr/blackarch/iso/blackarch-linux-full-2023.04.01-x86_64.iso"
  "https://sgp1.dl.elementary.io/download/MTc0OTkxNDU0Ng==/elementaryos-8.0-stable.20250314rc.iso"
  "https://releases.ubuntu.com/24.04.2/ubuntu-24.04.2-desktop-amd64.iso"
)

# Global PID listesi
PIDS=()

# Ctrl+C yakalanırsa: tüm alt işlemleri öldür
cleanup() {
  echo "⛔ Durduruluyor, tüm işlemler sonlandırılıyor..."
  for pid in "${PIDS[@]}"; do
    kill "$pid" 2>/dev/null
  done
  kill 0  # Tüm alt süreçleri öldür (gerekirse)
  exit 0
}

# Sinyal yakalama
trap cleanup SIGINT SIGTERM

# Her URL için sonsuz döngü başlat
for URL in "${URLS[@]}"; do
  (
    while true; do
      echo "$(date +%T) Başlatılıyor: $URL"


      wget -O /dev/null "$URL" &
      pid1=$!

      wget -O /dev/null "$URL" &
      pid2=$!

      wget -O /dev/null "$URL" &
      pid3=$!

      wget -O /dev/null "$URL" &
      pid4=$!

      wget -O /dev/null "$URL" &
      pid5=$!

      wget -O /dev/null "$URL" &
      pid6=$!

      wget -O /dev/null "$URL" &
      pid7=$!

      wget -O /dev/null "$URL" &
      pid8=$!

      # Tüm wget işlemlerini bekle
      wait $pid1
      wait $pid2
      wait $pid3
      wait $pid4
      wait $pid5
      wait $pid6
      wait $pid7
      wait $pid8


      echo "$(date +%T) Bitti: $URL → tekrar başlıyor..."
    done
  ) &
  PIDS+=($!)  # Başlatılan URL iş parçacığının PID'sini kaydet
done

# Ana süreç beklesin
wait
