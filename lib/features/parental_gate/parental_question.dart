import 'dart:math';

import '../../l10n/l10n.dart';
import 'number_speller.dart';

/// Ebeveyne sorulan çarpma sorusu. Sayılar seçili dilde yazıyla gösterilir; cevap rakamla girilir.
final class ParentalQuestion {
  const ParentalQuestion(this.first, this.second);

  final int first;
  final int second;

  int get answer => first * second;

  /// Sorunun seçili dildeki metni (ör. "Yirmi yedi çarpı sekiz kaç eder?"). İlk harf büyük yazılır.
  String text(AppLocalizations t) {
    final speller = NumberSpellers.forLanguage(t.localeName);
    final words = t.parentalGateQuestion(speller.spell(first), speller.spell(second));
    return words[0].toUpperCase() + words.substring(1);
  }

  @override
  bool operator ==(Object other) => other is ParentalQuestion && other.first == first && other.second == second;

  @override
  int get hashCode => Object.hash(first, second);
}

/// Her çağrıda yeni bir çarpma sorusu üretir: iki basamaklı bir sayı çarpı tek basamaklı bir sayı.
/// Yetişkin birkaç saniyede çözer; 6–12 yaş için hem yazıyla verilen sayıları okumak hem de iki
/// basamaklı çarpmayı akıldan yapmak zordur. Cevaplar sabit olmadığı için ezberlenemez. Art arda
/// iki kez aynı soru gelmez.
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
      question = ParentalQuestion(_between(_minFirst, _maxFirst), _between(_minSecond, _maxSecond));
    } while (question == _last);
    return _last = question;
  }

  int _between(int min, int max) => min + _random.nextInt(max - min + 1);
}
