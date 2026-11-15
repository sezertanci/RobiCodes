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
  static const byLanguage = <String, NumberSpeller>{
    'tr': TurkishNumberSpeller(),
    'en': _fallback,
    'de': GermanNumberSpeller(),
    'es': SpanishNumberSpeller(),
    'fr': FrenchNumberSpeller(),
  };

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

/// Almanca yazım: 1–19 kendine özgüdür; diğerlerinde birler önce gelir ve "und" ile bitişik yazılır
/// ("siebenundzwanzig"). Birleşik sayılarda 1, "eins" yerine "ein" olur ("einundzwanzig").
final class GermanNumberSpeller implements NumberSpeller {
  const GermanNumberSpeller();

  static const _small = [
    '',
    'eins',
    'zwei',
    'drei',
    'vier',
    'fünf',
    'sechs',
    'sieben',
    'acht',
    'neun',
    'zehn',
    'elf',
    'zwölf',
    'dreizehn',
    'vierzehn',
    'fünfzehn',
    'sechzehn',
    'siebzehn',
    'achtzehn',
    'neunzehn',
  ];
  static const _tens = ['', '', 'zwanzig', 'dreißig', 'vierzig', 'fünfzig', 'sechzig', 'siebzig', 'achtzig', 'neunzig'];
  static const _compoundOne = 'ein';

  @override
  String spell(int number) {
    _checkRange(number);
    if (number < _small.length) {
      return _small[number];
    }
    final tens = _tens[number ~/ _base];
    final unit = number % _base;
    if (unit == 0) {
      return tens;
    }
    final unitWord = unit == 1 ? _compoundOne : _small[unit];
    return '${unitWord}und$tens';
  }
}

/// İspanyolca yazım: 1–29 kendine özgüdür ("veintisiete"); 30 ve sonrasında onlar ile birler "y" ile
/// bağlanır ("treinta y uno").
final class SpanishNumberSpeller implements NumberSpeller {
  const SpanishNumberSpeller();

  static const _small = [
    '',
    'uno',
    'dos',
    'tres',
    'cuatro',
    'cinco',
    'seis',
    'siete',
    'ocho',
    'nueve',
    'diez',
    'once',
    'doce',
    'trece',
    'catorce',
    'quince',
    'dieciséis',
    'diecisiete',
    'dieciocho',
    'diecinueve',
    'veinte',
    'veintiuno',
    'veintidós',
    'veintitrés',
    'veinticuatro',
    'veinticinco',
    'veintiséis',
    'veintisiete',
    'veintiocho',
    'veintinueve',
  ];
  static const _tens = ['', '', '', 'treinta', 'cuarenta', 'cincuenta', 'sesenta', 'setenta', 'ochenta', 'noventa'];

  @override
  String spell(int number) {
    _checkRange(number);
    if (number < _small.length) {
      return _small[number];
    }
    final tens = _tens[number ~/ _base];
    final unit = number % _base;
    return unit == 0 ? tens : '$tens y ${_small[unit]}';
  }
}

/// Fransızca yazım: 1–19 kendine özgüdür; 70'ler ve 90'lar 60 ile 80'in üzerine 10–19 eklenerek
/// kurulur ("soixante-douze", "quatre-vingt-dix-sept"). 1 ve 11, 80'ler ile 90'lar dışında "et" ile
/// bağlanır ("vingt et un", "soixante et onze"); 80 tek başına "quatre-vingts" yazılır.
final class FrenchNumberSpeller implements NumberSpeller {
  const FrenchNumberSpeller();

  static const _small = [
    '',
    'un',
    'deux',
    'trois',
    'quatre',
    'cinq',
    'six',
    'sept',
    'huit',
    'neuf',
    'dix',
    'onze',
    'douze',
    'treize',
    'quatorze',
    'quinze',
    'seize',
    'dix-sept',
    'dix-huit',
    'dix-neuf',
  ];
  static const _tens = [
    '',
    '',
    'vingt',
    'trente',
    'quarante',
    'cinquante',
    'soixante',
    'soixante',
    'quatre-vingt',
    'quatre-vingt',
  ];

  /// Önceki onluğa 10–19 eklenerek yazılan onluklar (70'ler, 90'lar).
  static const _borrowingTens = {7, 9};

  /// "et" ile değil tireyle bağlanan onluklar (80'ler, 90'lar).
  static const _hyphenOnlyTens = {8, 9};

  /// Onluğa "et" ile bağlanan kalanlar ("et un", "et onze").
  static const _joinedWithEt = {1, 11};
  static const _eightyTens = 8;
  static const _plural = 's';

  @override
  String spell(int number) {
    _checkRange(number);
    if (number < _small.length) {
      return _small[number];
    }
    final tens = number ~/ _base;
    final rest = number % _base + (_borrowingTens.contains(tens) ? _base : 0);
    final tensWord = _tens[tens];
    if (rest == 0) {
      return tens == _eightyTens ? '$tensWord$_plural' : tensWord;
    }
    final joinWithEt = _joinedWithEt.contains(rest) && !_hyphenOnlyTens.contains(tens);
    return joinWithEt ? '$tensWord et ${_small[rest]}' : '$tensWord-${_small[rest]}';
  }
}
