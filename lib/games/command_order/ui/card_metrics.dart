/// Kart, kutu ve kart görselinin boyutları. Web sürümündeki gibi dar ekranda (560 dp altı)
/// küçük kartlar kullanılır; tablette boyutlar [ratio] oranında büyür.
final class CardMetrics {
  const CardMetrics._({
    required this.width,
    required this.height,
    required this.art,
    required this.padding,
    required this.fontSize,
    required this.numberSize,
  });

  factory CardMetrics.forWidth(double width, double ratio) {
    final compact = width < compactMaxWidth;
    return CardMetrics._(
      width: (compact ? 100 : 136) * ratio,
      height: (compact ? 120 : 156) * ratio,
      art: (compact ? 76 : 104) * ratio,
      padding: (compact ? 3 : 6) * ratio,
      fontSize: (compact ? 12 : 14) * ratio,
      numberSize: (compact ? 28 : 36) * ratio,
    );
  }

  /// Bu genişliğin altında küçük kartlar kullanılır (üç kart yan yana sığar).
  static const compactMaxWidth = 560.0;

  static const radius = 18.0;
  static const lip = 6.0;
  static const gap = 10.0;

  final double width;
  final double height;
  final double art;
  final double padding;
  final double fontSize;

  /// Boş kutudaki numaranın yazı boyu.
  final double numberSize;
}
