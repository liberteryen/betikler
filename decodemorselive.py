import pyaudio
import numpy as np
import time

# Morse kod sözlüğü
morse_dict = {
    '.-':'A', '-...':'B', '-.-.':'C', '-..':'D', '.':'E',
    '..-.':'F', '--.':'G', '....':'H', '..':'I', '.---':'J',
    '-.-':'K', '.-..':'L', '--':'M', '-.':'N', '---':'O',
    '.--.':'P', '--.-':'Q', '.-.':'R', '...':'S', '-':'T',
    '..-':'U', '...-':'V', '.--':'W', '-..-':'X', '-.--':'Y',
    '--..':'Z', '-----':'0', '.----':'1', '..---':'2',
    '...--':'3', '....-':'4', '.....':'5', '-....':'6',
    '--...':'7', '---..':'8', '----.':'9'
}

SAMPLE_RATE = 44100
CHUNK = 1024
THRESHOLD = 1000

DOT_TIME = 0.15  # saniye, buna göre çizgi hesaplanır

p = pyaudio.PyAudio()
stream = p.open(format=pyaudio.paInt16, channels=1, rate=SAMPLE_RATE,
                input=True, frames_per_buffer=CHUNK)

print("🔊 Mors kodu çözülüyor... (CTRL+C ile çık)")

prev_sound = False
start = time.time()
symbol = ""
current_morse = ""

try:
    while True:
        data = np.frombuffer(stream.read(CHUNK), dtype=np.int16)
        volume = np.abs(data).mean()

        now = time.time()

        if volume > THRESHOLD:
            # Ses var
            if not prev_sound:
                silence_duration = now - start
                if 0.2 < silence_duration < 0.7:
                    # Harf arası
                    if current_morse:
                        print(morse_dict.get(current_morse, '?'), end='', flush=True)
                        current_morse = ''
                elif silence_duration >= 0.7:
                    # Kelime arası
                    if current_morse:
                        print(morse_dict.get(current_morse, '?'), end='', flush=True)
                        current_morse = ''
                    print(' ', end='', flush=True)
                start = now
            prev_sound = True

        else:
            # Sessizlik
            if prev_sound:
                tone_duration = now - start
                if tone_duration < DOT_TIME:
                    current_morse += '.'
                else:
                    current_morse += '-'
                start = now
            prev_sound = False

except KeyboardInterrupt:
    print("\n🛑 Program sonlandırıldı.")
    stream.stop_stream()
    stream.close()
    p.terminate()
