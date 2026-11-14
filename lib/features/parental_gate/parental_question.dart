import 'dart:math';

/// Ebeveyne sorulan matematik sorusu. Sayılar yazıyla verilir; cevap rakamla girilir.
final class ParentalQuestion {
  const ParentalQuestion({required this.text, required this.answer});

  final String text;
  final int answer;
}

/// Her çağrıda yeni bir çarpma sorusu üretir: iki basamaklı bir sayı çarpı tek basamaklı bir sayı
/// (ör. "Yirmi yedi çarpı sekiz kaç eder?"). Yetişkin birkaç saniyede çözer; 6–12 yaş için hem
/// yazıyla verilen sayıları okumak hem de iki basamaklı çarpmayı akıldan yapmak zordur. Cevaplar
/// sabit olmadığı için ezberlenemez. Art arda iki kez aynı soru gelmez.
final class ParentalQuestionGenerator {
  ParentalQuestionGenerator(this._random);

  final Random _random;
  ParentalQuestion? _last;

  static const _minFirst = 12;
  static const _maxFirst = 29;
  static const _minSecond = 3;
  static const _maxSecond = 9;

  /// Cevabın en fazla basamak sayısı (29 × 9 = 261).
  static const maxAnswerDigits = 3;

  ParentalQuestion next() {
    ParentalQuestion question;
    do {
      question = _create();
    } while (question.text == _last?.text);
    return _last = question;
  }

  ParentalQuestion _create() {
    final first = _between(_minFirst, _maxFirst);
    final second = _between(_minSecond, _maxSecond);
    final words = '${TurkishNumbers.toWords(first)} çarpı ${TurkishNumbers.toWords(second)} kaç eder?';
    return ParentalQuestion(text: words[0].toUpperCase() + words.substring(1), answer: first * second);
  }

  int _between(int min, int max) => min + _random.nextInt(max - min + 1);
}

/// 1–99 arasındaki sayıların Türkçe yazılışı.
abstract final class TurkishNumbers {
  static const _ones = ['', 'bir', 'iki', 'üç', 'dört', 'beş', 'altı', 'yedi', 'sekiz', 'dokuz'];
  static const _tens = ['', 'on', 'yirmi', 'otuz', 'kırk', 'elli', 'altmış', 'yetmiş', 'seksen', 'doksan'];
  static const _base = 10;

  static String toWords(int number) {
    assert(number > 0 && number < _base * _base, 'Yalnızca 1–99 desteklenir.');
    return [_tens[number ~/ _base], _ones[number % _base]].where((part) => part.isNotEmpty).join(' ');
  }
}
