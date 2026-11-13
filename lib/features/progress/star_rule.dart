/// Seviye sonunda verilen yıldız kuralı. Bütün oyunlar aynı kuralı kullanır:
/// ipucu kullanılırsa 1, ipucusuz bitirilirse 2, ipucusuz ve hedefe uygun bitirilirse 3 yıldız.
abstract final class StarRule {
  static const completed = 1;
  static const noHint = 2;
  static const perfect = 3;

  static int calculate({required bool hintUsed, required bool targetMet}) {
    if (hintUsed) {
      return completed;
    }
    return targetMet ? perfect : noHint;
  }

  static bool isValid(int stars) => stars >= completed && stars <= perfect;

  static int clamp(int stars) => stars.clamp(completed, perfect);
}
