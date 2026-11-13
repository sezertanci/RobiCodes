"""Robi görselinden Android başlatıcı ikonlarını üretir (Pillow gerekir).

İkon: lacivert zeminde Robi; solunda yukarıdan aşağıya ışıklı yukarı ok, sarı ampul ve ışıklı sağa ok.
Oklar ve ampul Robi'nin renkleriyle (göz turkuazı, ağız sarısı) çizilir.

Kullanım: python tool/make_launcher_icon.py assets/characters/robot.webp android/app/src/main/res önizleme.png
"""
import math
import os
import sys

from PIL import Image, ImageDraw, ImageFilter

GLOW = (10, 234, 248)          # Robi'nin gözleri ve göğüs ışığı
TEAL = (0, 140, 190)           # okların koyu turkuaz kenarı
INK = (22, 26, 36)             # okların ve ampulün dış çizgisi
BULB = (252, 208, 4)           # Robi'nin ağzındaki sarı
BULB_DARK = (214, 140, 10)     # Robi'nin kulaklarındaki koyu sarı
BULB_LIGHT = (255, 238, 120)
SOCKET = (205, 214, 224)       # ampul duyunun çizgileri
BG_INNER = (52, 74, 120)       # zeminin açık ortası
BG_OUTER = (31, 45, 79)        # zeminin kenarı (AppColors.navy)

ROBOT_CROP = (0, 0, 355, 330)  # kafa, başparmak ve göğüs
ADAPTIVE_DP = 108              # uyarlanabilir ikon katmanı
LEGACY_DP = 48                 # Android 7 ve öncesi ikonu
VISIBLE_DP = 72                # uyarlanabilir ikonda kırpılmadan görünen alan
DENSITIES = {'mdpi': 1, 'hdpi': 1.5, 'xhdpi': 2, 'xxhdpi': 3, 'xxxhdpi': 4}

# Yerleşim, 108 dp katmanın oranları olarak (432 piksellik tasarım tuvalinden)
ROBOT_WIDTH = 0.54
ROBOT_SHIFT = 0.09
ROBOT_BOTTOM = 0.19
SYMBOL_X = 80 / 432
SYMBOL_TOPS = (116 / 432, 180 / 432, 244 / 432)
SYMBOL_SIZE = 64 / 432

# Ok ve ampul 128 birimlik bir kutuda tanımlanır ve UNIT_SCALE kat büyük çizilip küçültülür.
UNIT = 128
UNIT_SCALE = 4
BOX = UNIT * UNIT_SCALE
ARROW_SCALE = 1.3


def s(value):
    return int(value * UNIT_SCALE)


def scaled(points, k, cx=s(64), cy=s(63)):
    return [(cx + (x - cx) * k, cy + (y - cy) * k) for x, y in points]


def arrow_points(direction):
    """Dolgulu ok çokgeni: yukarı bakan biçim, yöne göre döndürülür."""
    points = [(64, 30), (94, 62), (76, 62), (76, 96), (52, 96), (52, 62), (34, 62)]
    angle = math.radians({'up': 0, 'right': 90}[direction])
    cx, cy = 64, 63
    return [(s(cx + (x - cx) * math.cos(angle) - (y - cy) * math.sin(angle)),
             s(cy + (x - cx) * math.sin(angle) + (y - cy) * math.cos(angle))) for x, y in points]


def blurred(shape_drawer, radius):
    layer = Image.new('RGBA', (BOX, BOX), (0, 0, 0, 0))
    shape_drawer(ImageDraw.Draw(layer))
    return layer.filter(ImageFilter.GaussianBlur(radius))


def arrow(size, direction):
    """Robi'nin gözleri gibi ışıklı, kutusuz ok."""
    im = Image.new('RGBA', (BOX, BOX), (0, 0, 0, 0))
    pts = scaled(arrow_points(direction), ARROW_SCALE)
    im.alpha_composite(blurred(lambda d: d.polygon(pts, fill=GLOW + (200,)), s(7)))
    d = ImageDraw.Draw(im)
    d.polygon(pts, fill=INK)
    d.line(pts + [pts[0]], fill=INK, width=s(9), joint='curve')
    inner = scaled(pts, 0.86)
    d.polygon(inner, fill=TEAL)
    d.polygon(scaled(inner, 0.8), fill=GLOW)
    im.alpha_composite(blurred(lambda d: d.polygon(scaled(inner, 0.45), fill=(255, 255, 255, 150)), s(2)))
    return im.resize((size, size), Image.LANCZOS)


def box(*values):
    return tuple(s(v) for v in values)


def bulb(size):
    """Okların tarzında ışıklı ampul: koyu dış çizgi, sarı cam, gri duy ve ışınlar."""
    im = Image.new('RGBA', (BOX, BOX), (0, 0, 0, 0))
    glass = box(34, 18, 94, 84)
    im.alpha_composite(blurred(lambda d: d.ellipse(glass, fill=BULB + (210,)), s(9)))
    d = ImageDraw.Draw(im)
    for ray in [(64, 4, 64, 13), (24, 22, 30, 28), (104, 22, 98, 28), (10, 52, 19, 52), (118, 52, 109, 52)]:
        d.line(box(*ray), fill=INK, width=s(9))
        d.line(box(*ray), fill=BULB, width=s(4))
    d.ellipse(box(30, 14, 98, 88), fill=INK)
    d.polygon([(s(x), s(y)) for x, y in [(44, 70), (84, 70), (80, 96), (48, 96)]], fill=INK)
    d.ellipse(glass, fill=BULB_DARK)
    d.polygon([(s(x), s(y)) for x, y in [(48, 74), (80, 74), (76, 92), (52, 92)]], fill=BULB_DARK)
    d.ellipse(box(40, 24, 88, 76), fill=BULB)
    d.ellipse(box(48, 30, 80, 62), fill=BULB_LIGHT)
    im.alpha_composite(blurred(lambda d: d.ellipse(box(46, 30, 64, 48), fill=(255, 255, 255, 190)), s(2)))
    d = ImageDraw.Draw(im)
    d.rounded_rectangle(box(46, 92, 82, 118), s(6), fill=INK)
    for y in (96, 104):
        d.rounded_rectangle(box(51, y, 77, y + 5), s(2), fill=SOCKET)
    d.rounded_rectangle(box(56, 112, 72, 122), s(4), fill=INK)
    return im.resize((size, size), Image.LANCZOS)


def foreground(robot, size):
    """108 dp ön plan katmanı: sağda Robi, solunda ok, ampul ve ok; hepsi görünür alanda."""
    canvas = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    w = int(size * ROBOT_WIDTH)
    h = int(robot.height * w / robot.width)
    x = (size - w) // 2 + int(size * ROBOT_SHIFT)
    canvas.alpha_composite(robot.resize((w, h), Image.LANCZOS), (x, size - h - int(size * ROBOT_BOTTOM)))
    symbol = int(size * SYMBOL_SIZE)
    makers = [lambda n: arrow(n, 'up'), bulb, lambda n: arrow(n, 'right')]
    for top, make in zip(SYMBOL_TOPS, makers):
        canvas.alpha_composite(make(symbol), (int(size * SYMBOL_X), int(size * top)))
    return canvas


def background(size):
    """Ortası açık, kenarları koyu lacivert geçişli zemin katmanı."""
    im = Image.new('RGBA', (size, size))
    px = im.load()
    cx, cy, radius = size * 0.475, size * 0.425, size * 0.72
    for y in range(size):
        for x in range(size):
            t = min(1, math.hypot(x - cx, y - cy) / radius)
            px[x, y] = tuple(int(a + (b - a) * t) for a, b in zip(BG_INNER, BG_OUTER)) + (255,)
    return im


def masked(image, round_shape, inset=0):
    """Görseli daire veya yuvarlak kare biçiminde keser."""
    n = image.width
    mask = Image.new('L', image.size, 0)
    area = (inset, inset, n - inset - 1, n - inset - 1)
    if round_shape:
        ImageDraw.Draw(mask).ellipse(area, fill=255)
    else:
        ImageDraw.Draw(mask).rounded_rectangle(area, radius=(n - 2 * inset) // 5, fill=255)
    out = Image.new('RGBA', image.size, (0, 0, 0, 0))
    out.paste(image, (0, 0), mask)
    return out.crop((inset, inset, n - inset, n - inset))


def full_icon(fg, bg):
    icon = bg.resize(fg.size, Image.LANCZOS)
    icon.alpha_composite(fg)
    return icon


def main():
    src, res, preview = sys.argv[1], sys.argv[2], sys.argv[3]
    robot = Image.open(src).convert('RGBA').crop(ROBOT_CROP)
    master_size = int(ADAPTIVE_DP * max(DENSITIES.values()) * 2)
    fg = foreground(robot, master_size)
    bg = background(ADAPTIVE_DP * 4)
    inset = master_size * (ADAPTIVE_DP - VISIBLE_DP) // (2 * ADAPTIVE_DP)
    icon = full_icon(fg, bg)
    for name, k in DENSITIES.items():
        folder = os.path.join(res, 'mipmap-' + name)
        os.makedirs(folder, exist_ok=True)
        layer = int(ADAPTIVE_DP * k)
        fg.resize((layer, layer), Image.LANCZOS).save(os.path.join(folder, 'ic_launcher_foreground.png'), optimize=True)
        bg.resize((layer, layer), Image.LANCZOS).save(os.path.join(folder, 'ic_launcher_background.png'), optimize=True)
        legacy = int(LEGACY_DP * k)
        for file, round_shape in (('ic_launcher.png', False), ('ic_launcher_round.png', True)):
            masked(icon, round_shape, inset).resize((legacy, legacy), Image.LANCZOS).save(
                os.path.join(folder, file), optimize=True)
    # Önizleme: yuvarlak kare ve daire maskeleriyle görünüm
    shown = 288
    sheet = Image.new('RGBA', (2 * shown + 60, shown + 40), (236, 236, 236, 255))
    for i, round_shape in enumerate((False, True)):
        sheet.alpha_composite(masked(icon, round_shape, inset).resize((shown, shown), Image.LANCZOS), (20 + i * (shown + 20), 20))
    sheet.save(preview)


if __name__ == '__main__':
    main()
