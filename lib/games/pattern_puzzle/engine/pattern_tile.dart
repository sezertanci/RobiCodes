import '../../path_finder/engine/lamp.dart';

/// Desenin bir parçası: renkli lamba ya da sayı.
sealed class PatternTile {
  const PatternTile();
}

/// [shape] biçiminde, [color] renginde lamba.
final class LampTile extends PatternTile {
  const LampTile(this.color, [this.shape = LampShape.circle]);

  final LampColor color;
  final LampShape shape;

  @override
  bool operator ==(Object other) => other is LampTile && other.color == color && other.shape == shape;

  @override
  int get hashCode => Object.hash(color, shape);
}

/// Sayı dizisinin bir sayısı.
final class NumberTile extends PatternTile {
  const NumberTile(this.value);

  final int value;

  @override
  bool operator ==(Object other) => other is NumberTile && other.value == value;

  @override
  int get hashCode => Object.hash(NumberTile, value);
}

/// Seviye verisindeki desen kısaltması. Parçalar boşlukla ayrılır: renk harfi (R kırmızı, B mavi, Y sarı,
/// G yeşil) ve isteğe bağlı biçim harfi (c daire, s kare, t üçgen) bir lambadır ("Rs" kırmızı kare); rakamlar
/// bir sayıdır. Köşeli parantezli parça ("[B]") eksiktir ve içindeki parça doğru cevaptır.
abstract final class PatternNotation {
  static const _missingStart = '[';
  static const _missingEnd = ']';

  static const _colors = {'R': LampColor.red, 'B': LampColor.blue, 'Y': LampColor.yellow, 'G': LampColor.green};
  static const _shapes = {'c': LampShape.circle, 's': LampShape.square, 't': LampShape.triangle};

  static List<String> _tokens(String text) => text.split(' ').where((token) => token.isNotEmpty).toList();

  static bool _isMissing(String token) => token.startsWith(_missingStart) && token.endsWith(_missingEnd);

  static List<PatternTile> parseTiles(String text) => [for (final token in _tokens(text)) _parseTile(token)];

  /// Eksik parçaların sırası.
  static List<int> parseMissing(String text) => [
    for (final (index, token) in _tokens(text).indexed)
      if (_isMissing(token)) index,
  ];

  static PatternTile _parseTile(String token) {
    final text = _isMissing(token) ? token.substring(1, token.length - 1) : token;
    if (int.tryParse(text) case final value?) {
      return NumberTile(value);
    }
    final color = _colors[text[0]];
    final shape = text.length > 1 ? _shapes[text.substring(1)] : LampShape.circle;
    if (color == null || shape == null) {
      throw ArgumentError.value(token, 'token', 'Tanınmayan desen parçası.');
    }
    return LampTile(color, shape);
  }

  /// Desendeki farklı parçalar, ilk göründükleri sırayla.
  static List<PatternTile> distinctTiles(List<PatternTile> tiles) => tiles.toSet().toList();
}
