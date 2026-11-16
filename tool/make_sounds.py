"""Web sürümündeki ses efektlerini (MiniCodingWorld/js/core/sound.js) WAV dosyalarına çevirir.

Web sürümü ses dosyası kullanmaz; notaları tarayıcıda Web Audio ile üretir. Bu betik aynı notaları,
aynı dalga biçimini ve aynı ses zarfını (kısa yükseliş, üstel sönme) kullanarak dosyaya yazar.
Böylece uygulamadaki sesler web sürümüyle aynı olur. Tuş ve adım sesleri yalnızca uygulamada vardır. Yalnızca Python'un standart kütüphanesi gerekir.

Kullanım: python tool/make_sounds.py assets/sounds
"""
import math
import os
import struct
import sys
import wave

SAMPLE_RATE = 44100
VOLUME = 0.18
ATTACK_SECONDS = 0.02
SILENT_GAIN = 0.0001        # Üstel azalma sıfıra inemez; duyulmayacak kadar küçük bir değer.
STEP_SEMITONES = 4          # Yıldız sesi her adımda bu kadar yarım ses yükselir.
SEMITONES_PER_OCTAVE = 12
STAR_STEPS = 3              # Sonuç panelindeki en fazla yıldız sayısı (StarRule.perfect).
MAX_SAMPLE = 32767

# Her nota: (frekans Hz, başlangıç sn, süre sn). Değerler web sürümüyle aynıdır.
MELODIES = {
    'badge': [(784, 0, 0.14), (988, 0.12, 0.14), (1319, 0.24, 0.3)],
    'trophy': [(523, 0, 0.16), (659, 0.16, 0.16), (784, 0.32, 0.16), (1047, 0.48, 0.24), (784, 0.72, 0.14),
               (1047, 0.86, 0.6)],
    'correct': [(659, 0, 0.12), (988, 0.1, 0.22)],
    'wrong': [(440, 0, 0.2), (370, 0.18, 0.3)],
    'star': [(880, 0, 0.12), (1319, 0.06, 0.22)],
    'level-complete': [(523, 0, 0.12), (659, 0.1, 0.12), (784, 0.2, 0.12), (1047, 0.3, 0.4)],
    # Web sürümünde olmayan, yalnızca uygulamaya eklenen sesler: tuş tıklaması ve robotun her adımı.
    'tap': [(1047, 0, 0.06)],
    'step': [(392, 0, 0.08)],
}

# Yumuşak (sinüs) dalgayla çalınan efektler; diğerleri daha parlak üçgen dalgayla çalınır.
SOFT_SOUNDS = {'wrong', 'tap', 'step'}


def sine(phase):
    return math.sin(2 * math.pi * phase)


def triangle(phase):
    return 1 - 4 * abs(phase - math.floor(phase + 0.5))


def gain_at(t, duration):
    """Web Audio'daki iki üstel rampa: 0'dan VOLUME'a yükseliş, sonra SILENT_GAIN'e sönme."""
    if t < ATTACK_SECONDS:
        return SILENT_GAIN * (VOLUME / SILENT_GAIN) ** (t / ATTACK_SECONDS)
    fade = (t - ATTACK_SECONDS) / (duration - ATTACK_SECONDS)
    return VOLUME * (SILENT_GAIN / VOLUME) ** fade


def transpose(frequency, step):
    return frequency * 2 ** (step * STEP_SEMITONES / SEMITONES_PER_OCTAVE)


def render(notes, wave_function, step=0):
    length = max(start + duration for _, start, duration in notes)
    samples = [0.0] * math.ceil(length * SAMPLE_RATE)
    for frequency, start, duration in notes:
        pitch = transpose(frequency, step)
        first = round(start * SAMPLE_RATE)
        for i in range(round(duration * SAMPLE_RATE)):
            t = i / SAMPLE_RATE
            samples[first + i] += wave_function(pitch * t) * gain_at(t, duration)
    return samples


def write_wav(path, samples):
    with wave.open(path, 'wb') as file:
        file.setnchannels(1)
        file.setsampwidth(2)
        file.setframerate(SAMPLE_RATE)
        file.writeframes(b''.join(struct.pack('<h', round(max(-1, min(1, s)) * MAX_SAMPLE)) for s in samples))


def main(output_dir):
    os.makedirs(output_dir, exist_ok=True)
    for name, notes in MELODIES.items():
        wave_function = sine if name in SOFT_SOUNDS else triangle
        # Yıldız sesi her yıldızda tonu yükselen ayrı dosyalar olarak yazılır: star-0, star-1, star-2.
        steps = range(STAR_STEPS) if name == 'star' else [None]
        for step in steps:
            file_name = f'{name}.wav' if step is None else f'{name}-{step}.wav'
            write_wav(os.path.join(output_dir, file_name), render(notes, wave_function, step or 0))
            print(file_name)


if __name__ == '__main__':
    main(sys.argv[1])
