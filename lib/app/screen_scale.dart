import 'package:flutter/widgets.dart';

/// Ekranın kısa kenarına göre büyüyen boyutlar. Telefonda taban değerler aynen kalır;
/// tablette düğmeler ve kutular orantılı olarak büyür, ama verilen üst sınırı aşmaz.
final class ScreenScale {
  const ScreenScale._(this.factor);

  /// Verilen ekran boyutu için ölçek. Testlerde de doğrudan kullanılır.
  factory ScreenScale.fromSize(Size size) =>
      ScreenScale._((size.shortestSide / referenceShortestSide).clamp(1.0, maxFactor));

  factory ScreenScale.of(BuildContext context) => ScreenScale.fromSize(MediaQuery.sizeOf(context));

  /// Kısa kenarı bu değer ve altında olan ekranlar telefon sayılır; taban boyutlar kullanılır.
  static const referenceShortestSide = 400.0;

  /// Bu genişlik ve üstündeki ekranlar geniş düzen kullanır (ör. yatay tablet).
  static const wideMinWidth = 760.0;

  /// Tabanın en fazla kaç katına büyünebileceği.
  static const maxFactor = 1.6;

  final double factor;

  /// Taban boyutun ekrana göre büyütülmüş hali; [max] verilirse onu aşmaz.
  double size(double base, {double? max}) {
    final scaled = base * factor;
    return max == null || scaled < max ? scaled : max;
  }
}
