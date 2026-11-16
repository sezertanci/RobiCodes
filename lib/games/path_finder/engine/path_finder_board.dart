/// Haritadaki bir kare. Kayıt (record) olduğu için değer eşitliği kendiliğinden vardır.
typedef GridPoint = ({int x, int y});

/// Robotun yön komutları. Sıra önemlidir: en kısa yol araması yönleri bu sırayla dener ve
/// ipucunun hangi yolu seçeceği buna bağlıdır (web sürümüyle aynı: yukarı, aşağı, sola, sağa).
enum Direction {
  up(0, -1, 'U'),
  down(0, 1, 'D'),
  left(-1, 0, 'L'),
  right(1, 0, 'R');

  const Direction(this.dx, this.dy, this.code);

  final int dx;
  final int dy;

  /// Seviye verisindeki çözüm kısaltmasındaki harf ("RRD" = sağa, sağa, aşağı).
  final String code;

  GridPoint from(GridPoint point) => (x: point.x + dx, y: point.y + dy);

  /// "URR" gibi bir çözüm metnini komut listesine çevirir.
  static List<Direction> parseSolution(String text) => [
    for (final letter in text.split('')) values.firstWhere((direction) => direction.code == letter),
  ];
}

/// Robotun geçemediği engeller.
enum Obstacle { rock, water, edge }

/// Harita metnindeki işaretler.
abstract final class TileSymbols {
  static const start = 'S';
  static const goal = 'G';
  static const rock = '#';
  static const water = '~';
  static const coin = '*';

  /// Boş çim kare; ayrıştırırken tanınmayan her işaret de boş sayılır.
  static const empty = '.';
}

/// Harita metninden çözülmüş oyun alanı: boyut, başlangıç, bayrak, engeller ve altınlar.
final class PathFinderBoard {
  const PathFinderBoard._({
    required this.width,
    required this.height,
    required this.start,
    required this.goal,
    required this.obstacles,
    required this.coins,
  });

  /// Harita satırlarını çözer. Satırlar eşit uzunlukta olmalı; tek bir başlangıç ve bayrak bulunmalıdır.
  factory PathFinderBoard.parse(List<String> rows) {
    GridPoint? start;
    GridPoint? goal;
    final obstacles = <GridPoint, Obstacle>{};
    final coins = <GridPoint>[];
    for (final (y, row) in rows.indexed) {
      for (final (x, symbol) in row.split('').indexed) {
        final point = (x: x, y: y);
        switch (symbol) {
          case TileSymbols.start:
            start = point;
          case TileSymbols.goal:
            goal = point;
          case TileSymbols.rock:
            obstacles[point] = Obstacle.rock;
          case TileSymbols.water:
            obstacles[point] = Obstacle.water;
          case TileSymbols.coin:
            coins.add(point);
        }
      }
    }
    if (start == null || goal == null) {
      throw ArgumentError.value(rows, 'rows', 'Haritada başlangıç (S) ve bayrak (G) bulunmalı.');
    }
    return PathFinderBoard._(
      width: rows.first.length,
      height: rows.length,
      start: start,
      goal: goal,
      obstacles: Map.unmodifiable(obstacles),
      coins: List.unmodifiable(coins),
    );
  }

  final int width;
  final int height;
  final GridPoint start;
  final GridPoint goal;
  final Map<GridPoint, Obstacle> obstacles;

  /// Altınlar soldan sağa, yukarıdan aşağı okunma sırasıyla numaralanır.
  final List<GridPoint> coins;

  bool isInside(GridPoint point) => point.x >= 0 && point.y >= 0 && point.x < width && point.y < height;

  /// Robot bu kareye giremiyorsa engelin türü, girebiliyorsa `null`.
  Obstacle? obstacleAt(GridPoint point) => isInside(point) ? obstacles[point] : Obstacle.edge;

  bool isWalkable(GridPoint point) => obstacleAt(point) == null;

  /// Karedeki altının sırası; altın yoksa `null`.
  int? coinIndexAt(GridPoint point) {
    final index = coins.indexOf(point);
    return index < 0 ? null : index;
  }
}
