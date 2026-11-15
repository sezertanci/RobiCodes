/// Ebeveyn sorusundaki sayıları bir dilde yazıyla ifade eder. Yeni bir dil eklendiğinde o dilin
/// yazımı burada tanımlanır ve [NumberSpellers] içine kaydedilir.
abstract interface class NumberSpeller {
  /// 1–99 arasındaki [number] sayısının yazılışı (ör. "yirmi yedi", "twenty-seven").
  String spell(int number);
}

/// Dil koduna göre sayı yazımını seçer. Yazımı tanımlanmamış bir dilde İngilizce kullanılır.
abstract final class NumberSpellers {
  static const _fallback = EnglishNumberSpeller();

  /// Yazımı tanımlı diller; her desteklenen dilin burada olduğu testle denetlenir.
  static const byLanguage = <String, NumberSpeller>{'tr': TurkishNumberSpeller(), 'en': _fallback};

  static NumberSpeller forLanguage(String languageCode) => byLanguage[languageCode] ?? _fallback;
}

/// Desteklenen sayı aralığının üst sınırı (dahil değil).
const _limit = 100;
const _base = 10;

void _checkRange(int number) {
  assert(number > 0 && number < _limit, 'Yalnızca 1–99 desteklenir.');
}

/// Türkçe yazım: onlar ve birler boşlukla yazılır ("yirmi yedi", "on iki").
final class TurkishNumberSpeller implements NumberSpeller {
  const TurkishNumberSpeller();

  static const _ones = ['', 'bir', 'iki', 'üç', 'dört', 'beş', 'altı', 'yedi', 'sekiz', 'dokuz'];
  static const _tens = ['', 'on', 'yirmi', 'otuz', 'kırk', 'elli', 'altmış', 'yetmiş', 'seksen', 'doksan'];

  @override
  String spell(int number) {
    _checkRange(number);
    return [_tens[number ~/ _base], _ones[number % _base]].where((part) => part.isNotEmpty).join(' ');
  }
}

/// İngilizce yazım: 10–19 kendine özgüdür, diğerlerinde onlar ve birler tireyle yazılır ("twenty-seven").
final class EnglishNumberSpeller implements NumberSpeller {
  const EnglishNumberSpeller();

  static const _ones = ['', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];
  static const _teens = [
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen',
  ];
  static const _tens = ['', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'];

  @override
  String spell(int number) {
    _checkRange(number);
    final tens = number ~/ _base;
    if (tens == 1) {
      return _teens[number % _base];
    }
    return [_tens[tens], _ones[number % _base]].where((part) => part.isNotEmpty).join('-');
  }
}
