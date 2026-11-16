import '../progress/star_rule.dart';

/// Uygulamadaki ses efektleri. Dosyalar web sürümündeki notalardan `tool/make_sounds.py` ile üretildi.
enum SoundEffect {
  correct('correct'),
  wrong('wrong'),

  /// Sonuç panelinde beliren her yıldızda tonu biraz daha yükselen parıltı (bkz. [assetFor]).
  star('star'),
  levelComplete('level-complete'),
  badge('badge'),
  trophy('trophy'),

  /// Tuşa basılınca çalan kısa tıklama (bkz. `withTapSound`).
  tap('tap'),

  /// Robot haritada bir kare ilerleyince çalan yumuşak adım sesi.
  step('step');

  const SoundEffect(this.fileName);

  final String fileName;

  static const _folder = 'assets/sounds';

  /// Efektin ses dosyası. Yıldız sesinde [step] kaçıncı yıldız olduğudur (0'dan başlar); diğer
  /// efektlerde kullanılmaz.
  String assetFor([int step = 0]) =>
      this == star ? '$_folder/$fileName-${step.clamp(0, StarRule.perfect - 1)}.wav' : '$_folder/$fileName.wav';
}
