"""Google Play mağaza girişi için uygulama simgesini ve öne çıkan görseli üretir (Pillow gerekir).

Simge, başlatıcı ikonuyla aynı tasarımdır (make_launcher_icon.py). Öne çıkan görselde aynı lacivert
zeminde solda uygulama adı ve slogan, sağda Robi ile iki arkadaşı yer alır. Öne çıkan görsel mağaza
girişinin her dili için ayrı üretilir (feature-graphic-<dil>.png); yeni bir dil TEXTS sözlüğüne eklenir.
Yazı tipi işletim sistemine göre değiştiği için yolu parametre olarak verilir; Türkçe karakterleri
içeren kalın bir yazı tipi seçilmelidir.

Kullanım: python tool/make_store_graphics.py assets/characters store/robi-codes <kalın-yazı-tipi.ttf>
"""
import os
import sys

from PIL import Image, ImageDraw, ImageFont

from make_launcher_icon import (ADAPTIVE_DP, BULB, ROBOT_CROP, VISIBLE_DP, background, bulb,
                                foreground, full_icon)

ICON_SIZE = 512
ICON_MASTER = ICON_SIZE * ADAPTIVE_DP // VISIBLE_DP  # görünür alan tam 512 piksel olsun diye

FEATURE_SIZE = (1024, 500)
# Dil kodu → (uygulama adı, slogan); uygulamadaki appTitle metniyle aynı olmalıdır.
TEXTS = {
    'tr': ('Robi Kodluyor', 'Robotla oyna, kodlamayı öğren!'),
    'en': ('Robi Codes', 'Play with a robot, learn to code!'),
}
TITLE_PX = 78
SLOGAN_PX = 33
TEXT_LEFT = 64
TITLE_TOP = 165
SLOGAN_GAP = 22
WHITE = (255, 255, 255)

# Sağdaki robotlar: (dosya, yükseklik, sol kenar, alt boşluk); ortadaki Robi öndedir.
ROBOTS = [
    ('robot-ribbon.webp', 230, 660, 125),
    ('robot-knight.webp', 230, 852, 150),
    ('robot.webp', 300, 728, 40),
]
BULB_SIZE = 84
BULB_POS = (TEXT_LEFT, 60)


def store_icon(robot_path):
    """Başlatıcı ikonunun kırpılmadan görünen alanı; Play köşeleri kendisi yuvarlar."""
    robot = Image.open(robot_path).convert('RGBA').crop(ROBOT_CROP)
    icon = full_icon(foreground(robot, ICON_MASTER), background(ADAPTIVE_DP * 4))
    inset = (ICON_MASTER - ICON_SIZE) // 2
    return icon.crop((inset, inset, inset + ICON_SIZE, inset + ICON_SIZE)).convert('RGB')


def feature_graphic(characters, font_path, title, slogan):
    width, height = FEATURE_SIZE
    canvas = background(width).crop((0, (width - height) // 2, width, (width + height) // 2))
    canvas.alpha_composite(bulb(BULB_SIZE), BULB_POS)
    for name, h, left, bottom in ROBOTS:
        robot = Image.open(os.path.join(characters, name)).convert('RGBA')
        w = robot.width * h // robot.height
        canvas.alpha_composite(robot.resize((w, h), Image.LANCZOS), (left, height - h - bottom))
    draw = ImageDraw.Draw(canvas)
    title_font = ImageFont.truetype(font_path, TITLE_PX)
    draw.text((TEXT_LEFT, TITLE_TOP), title, font=title_font, fill=WHITE)
    slogan_top = TITLE_TOP + TITLE_PX + SLOGAN_GAP
    draw.text((TEXT_LEFT, slogan_top), slogan, font=ImageFont.truetype(font_path, SLOGAN_PX), fill=BULB)
    return canvas.convert('RGB')


def main():
    characters, out, font_path = sys.argv[1], sys.argv[2], sys.argv[3]
    os.makedirs(out, exist_ok=True)
    store_icon(os.path.join(characters, 'robot.webp')).save(os.path.join(out, 'icon-512.png'), optimize=True)
    for language, (title, slogan) in TEXTS.items():
        graphic = feature_graphic(characters, font_path, title, slogan)
        graphic.save(os.path.join(out, f'feature-graphic-{language}.png'), optimize=True)


if __name__ == '__main__':
    main()
