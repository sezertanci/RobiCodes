import '../path_finder/engine/path_finder_board.dart';
import '../path_finder/path_finder_texts.dart';
import 'engine/repeat_program.dart';

/// Oyunun ekranda görünen metinleri. Web sürümündeki mesajların aynısıdır.
abstract final class RepeatTexts {
  static const intro = 'Robotu bayrağa götür. Aynı hareketi tekrar tekrar eklemek yerine Tekrarla bloğunu kullan.';
  static const coinIntro = 'Önce bütün altınları topla, sonra bayrağa git. Tekrarla bloğu işini kolaylaştırır.';
  static const empty = 'Önce bir ok ya da Tekrarla bloğu ekle.';
  static const full =
      'Blok sınırına ulaştın. Hazırsan yeşil Başlat tuşuna dokun; değiştirmek istersen bir bloğu seçip sil.';
  static const insideRepeat =
      'Şimdi eklediğin oklar turuncu bloğun içine girecek. Bitince lacivert Bloktan çık düğmesine dokun.';
  static const emptyStrip = 'Ok ya da Tekrarla bloğu ekle, bloklar burada sıralansın.';
  static const outsideRepeat = 'Şimdi eklediğin oklar bloğun dışına, sona eklenecek.';
  static const movedOut = 'Ok bloğun dışına çıktı. Şimdi eklediğin oklar da dışarıya, sona eklenecek.';
  static const emptyRepeat = 'Turuncu bloğun içi boş. Onu seçtim; şimdi içine bir ok ekle.';
  static const running = PathFinderTexts.running;
  static const success = PathFinderTexts.success;
  static const missedGoal = 'Robot bayrağa ulaşamadı. Tekrar sayısını ya da okları değiştirmeyi dene.';
  static const missingCoins = PathFinderTexts.missingCoins;
  static const solved = 'Blokların doğru! Yeşil Başlat tuşuna dokun.';
  static const fullHint =
      'Blok sınırın doldu. Bir tekrar sayısını değiştirmeyi ya da bir bloğu silip yerine Tekrarla bloğu koymayı dene.';
  static const addRepeat = 'Tekrarla';
  static const leaveRepeat = 'Bloktan çık ✓';
  static const addRepeatLabel = 'Tekrarla bloğu ekle';
  static const leaveRepeatLabel = 'Bloktan çık; sonraki oklar dışarıya eklensin';
  static const repeatWord = 'tekrarla';
  static const dropHere = 'Okları buraya ekle';
  static const emptyBody = 'Boş';
  static const decrease = 'Tekrar sayısını azalt';
  static const increase = 'Tekrar sayısını artır';
  static const deleteLabel = 'Seçili bloğu sil';
  static const moveOutLabel = 'Seçili oku turuncu bloğun dışına taşı';
  static const run = PathFinderTexts.run;
  static const hint = PathFinderTexts.hint;
  static const clear = PathFinderTexts.clear;

  static String times(int times) => '$times kez';

  static String addMove(Direction direction) => '${PathFinderTexts.label(direction)} oku ekle';

  static String moveChip(ProgramPlace place, Direction direction) {
    final name = Places.isInner(place) ? '${place.inner + 1}. ok' : '${place.block + 1}. blok';
    return '$name: ${PathFinderTexts.label(direction)}';
  }

  static String repeatLabel(int index, int times) =>
      '${index + 1}. blok: $times kez tekrarla. İçine ok eklemek için dokun.';

  static String round(int round, int times) => '${round + 1}/$times';

  static String placeName(ProgramPlace place) =>
      Places.isInner(place) ? '${place.block + 1}. bloğun içindeki ${place.inner + 1}. ok' : '${place.block + 1}. blok';

  /// Tekrar bloğu ilk turu sorunsuz geçip sonraki bir turda yoldan çıktıysa sorun büyük olasılıkla
  /// tekrar sayısıdır.
  static String fixAdvice(ProgramStep step) => _laterRound(step)
      ? '${step.block + 1}. bloğun tekrar sayısını ya da içindeki okları değiştirmeyi dene.'
      : '${placeName(Places.of(step))} robotu yoldan çıkarıyor.';

  static String blocked(Obstacle obstacle, ProgramStep step) {
    final when = _laterRound(step) ? '${step.round + 1}. turda ' : '';
    return 'Robot $when${PathFinderTexts.obstacleName(obstacle)} çarptı. ${fixAdvice(step)}';
  }

  static String fixHint(ProgramStep step) => '${fixAdvice(step)} Yanlış yeri senin için kırmızıyla gösterdim.';

  static String fullLevelHint(String levelHint) => '$levelHint $fullHint';

  static String nextMoveHint(String levelHint, Direction direction) =>
      '$levelHint Parlayan kareye bak; robot oraya ${PathFinderTexts.label(direction).toLowerCase()} gitmeli.';

  static bool _laterRound(ProgramStep step) => Places.isInner(Places.of(step)) && step.round > 0;
}
