import 'engine/path_finder_board.dart';

/// Oyunun ekranda görünen metinleri. Web sürümündeki mesajların aynısıdır.
abstract final class PathFinderTexts {
  static const title = 'Robotun Yolunu Bul';
  static const intro = 'Robotu bayrağa ulaştırmak için komutları sırayla seç.';
  static const coinIntro = 'Önce bütün altınları topla, sonra bayrağa git.';
  static const empty = 'Önce bir yön komutu ekle.';
  static const full = 'Komut sınırına ulaştın. Bir komutu silip yerine başkasını koyabilirsin.';
  static const running = 'Robot yola çıktı...';
  static const success = 'Harika! Robot bayrağa ulaştı!';
  static const missedGoal = 'Robot bayrağa ulaşamadı. Komut eklemeyi ya da değiştirmeyi dene.';
  static const missingCoins = 'Bayrağa ulaştın ama bütün altınları toplamadın. Önce altınları topla.';
  static const tooMany = 'Bu komutlarla sınır içinde bitiremezsin. Gereksiz adımları silmeyi dene.';
  static const solved = 'Komutların doğru! Yeşil Başlat tuşuna dokun.';
  static const emptyStrip = 'Yön tuşlarına bas, komutların burada sıralansın.';
  static const run = 'Başlat';
  static const hint = 'İpucu';
  static const clear = 'Temizle';
  static const delete = 'Sil';
  static const moveLeft = 'Seçili komutu bir sola taşı';
  static const moveRight = 'Seçili komutu bir sağa taşı';

  static String label(Direction direction) => switch (direction) {
        Direction.up => 'Yukarı',
        Direction.down => 'Aşağı',
        Direction.left => 'Sola',
        Direction.right => 'Sağa',
      };

  static String _obstacleName(Obstacle obstacle) => switch (obstacle) {
        Obstacle.rock => 'taşa',
        Obstacle.water => 'suya',
        Obstacle.edge => 'harita kenarına',
      };

  static String blocked(Obstacle obstacle, int index) =>
      'Robot ${_obstacleName(obstacle)} çarptı. ${index + 1}. komutu değiştirmeyi dene.';

  static String fixCommand(int index) =>
      '${index + 1}. komut robotu yoldan çıkarıyor. Onu senin için seçtim; silebilir ya da yerini değiştirebilirsin.';

  static String nextMove(Direction direction) => 'Parlayan kareye bak. Sıradaki komut: ${label(direction)}.';

  static String addCommand(Direction direction) => '${label(direction)} komutu ekle';

  static String commandChip(int index, Direction direction) => '${index + 1}. komut: ${label(direction)}';
}
