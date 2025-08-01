# Tempo (hız) %6 artır (x1.06) ve frekansı %25 artır (x1.25 varsayılan giriş frekansı = 44100 Hz)
ffmpeg -i input.mp3 -filter:a "atempo=1.06,asetrate=44100*1.25" output.mp3

# Tempo artırmadan sadece frekansı yükselt
ffmpeg -i input.mp3 -filter:a "asetrate=44100*1.25" output.mp3

# .mp3 ve .jpg dosyasından tek karelik .mp4 oluştur
ffmpeg -i output.mp3 -i anime.jpg output.mp4

# Yukarıdakilerin hepsini tek komutla yap (tempo artırmalı)
ffmpeg -i input.mp3 -i anime.jpg -filter:a "atempo=1.06,asetrate=44100*1.25" -vn output.mp4

# Tempo artırmadan tek komutla yap
ffmpeg -i input.mp3 -i anime.jpg -filter:a "asetrate=44100*1.25" -vn output.mp4
