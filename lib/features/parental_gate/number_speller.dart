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
    'pt': PortugueseNumberSpeller(),
    'it': ItalianNumberSpeller(),
    'id': IndonesianNumberSpeller(),
  };

  static NumberSpeller forLanguage(String languageCode) => byLanguage[languageCode] ?? _fallback;
}

/// Desteklenen sayı aralığının üst sınırı (dahil değil).
const _limit = 100;
const _base = 10;

void _checkRange(int number) {
  assert(number > 0 && number < _limit, 'Yalnızca 1–99 desteklenir.');
}

/// [small] tablosunda olan sayıyı oradan alır; diğerlerinde onluğu ve birliği [connector] ile bağlar
/// ("treinta y uno", "dua puluh tujuh"). [tens] onluğun basamağına göre dizilmiş onluk adlarıdır.
String _spellWithConnector(int number, List<String> small, List<String> tens, String connector) {
  _checkRange(number);
  if (number < small.length) {
    return small[number];
  }
  final tensWord = tens[number ~/ _base];
  final unit = number % _base;
  return unit == 0 ? tensWord : '$tensWord$connector${small[unit]}';
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
  String spell(int number) => _spellWithConnector(number, _small, _tens, ' y ');
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

/// Portekizce (Brezilya) yazım: 1–19 kendine özgüdür; diğerlerinde onlar ile birler "e" ile bağlanır
/// ("vinte e sete").
final class PortugueseNumberSpeller implements NumberSpeller {
  const PortugueseNumberSpeller();

  static const _small = [
    '',
    'um',
    'dois',
    'três',
    'quatro',
    'cinco',
    'seis',
    'sete',
    'oito',
    'nove',
    'dez',
    'onze',
    'doze',
    'treze',
    'catorze',
    'quinze',
    'dezesseis',
    'dezessete',
    'dezoito',
    'dezenove',
  ];
  static const _tens = [
    '',
    '',
    'vinte',
    'trinta',
    'quarenta',
    'cinquenta',
    'sessenta',
    'setenta',
    'oitenta',
    'noventa',
  ];

  @override
  String spell(int number) => _spellWithConnector(number, _small, _tens, ' e ');
}

/// İtalyanca yazım: 1–19 kendine özgüdür; diğerlerinde onlar ile birler bitişik yazılır ("ventisette").
/// Birler 1 veya 8 ise onluğun son ünlüsü düşer ("ventuno", "trentotto"); birlerdeki 3 vurguyla yazılır
/// ("ventitré").
final class ItalianNumberSpeller implements NumberSpeller {
  const ItalianNumberSpeller();

  static const _small = [
    '',
    'uno',
    'due',
    'tre',
    'quattro',
    'cinque',
    'sei',
    'sette',
    'otto',
    'nove',
    'dieci',
    'undici',
    'dodici',
    'tredici',
    'quattordici',
    'quindici',
    'sedici',
    'diciassette',
    'diciotto',
    'diciannove',
  ];
  static const _tens = [
    '',
    '',
    'venti',
    'trenta',
    'quaranta',
    'cinquanta',
    'sessanta',
    'settanta',
    'ottanta',
    'novanta',
  ];

  /// Ünlüyle başladığı için onluğun son ünlüsünü düşüren birler ("uno", "otto").
  static const _elidingUnits = {1, 8};

  /// Birleşik sayıda farklı yazılan birler.
  static const _compoundUnits = {3: 'tré'};

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
    final tensWord = _elidingUnits.contains(unit) ? tens.substring(0, tens.length - 1) : tens;
    return '$tensWord${_compoundUnits[unit] ?? _small[unit]}';
  }
}

/// Endonezce yazım: 11–19 "belas", onluklar "puluh" ile kurulur; onlar ile birler boşlukla yazılır
/// ("dua puluh tujuh").
final class IndonesianNumberSpeller implements NumberSpeller {
  const IndonesianNumberSpeller();

  static const _small = [
    '',
    'satu',
    'dua',
    'tiga',
    'empat',
    'lima',
    'enam',
    'tujuh',
    'delapan',
    'sembilan',
    'sepuluh',
    'sebelas',
    'dua belas',
    'tiga belas',
    'empat belas',
    'lima belas',
    'enam belas',
    'tujuh belas',
    'delapan belas',
    'sembilan belas',
  ];
  static const _tens = [
    '',
    '',
    'dua puluh',
    'tiga puluh',
    'empat puluh',
    'lima puluh',
    'enam puluh',
    'tujuh puluh',
    'delapan puluh',
    'sembilan puluh',
  ];

  @override
  String spell(int number) => _spellWithConnector(number, _small, _tens, ' ');
}
