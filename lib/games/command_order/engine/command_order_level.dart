/// Görevin bir adımı veya göreve ait olmayan bir kart: kısa yazı ve eylemi anlatan görsel.
final class CommandStep {
  const CommandStep(this.text, this.icon);

  final String text;

  /// Görselin asset yolu (`.webp` veya `.svg`).
  final String icon;
}

/// Adımları ara hedeflere bölen başlık (Zor ve Uzman). [size] bu aşamadaki kutu sayısıdır.
final class TaskStage {
  const TaskStage(this.title, this.size);

  final String title;
  final int size;
}

/// "Komutları Sırala" seviyesi: bir görev ve onun doğru sıradaki adımları.
final class CommandOrderLevel {
  const CommandOrderLevel({
    required this.title,
    required this.icon,
    required this.steps,
    required this.hint,
    this.stages,
    this.extras = const [],
  });

  final String title;

  /// Görevin büyük görseli.
  final String icon;

  /// Adımlar, doğru sırayla. Ekranda karışık gösterilir.
  final List<CommandStep> steps;

  /// İpucu düğmesine basılınca robotun söylediği cümle.
  final String hint;

  /// Ara hedefler; yoksa bütün kutular başlıksız tek bir grup olur. Boyların toplamı adım sayısıdır.
  final List<TaskStage>? stages;

  /// Göreve ait olmayan kartlar (Uzman). Sıraya konmamalıdır.
  final List<CommandStep> extras;

  /// Kutuların aşamalara bölünmüş hali; her grup kendi kutu sıralarını tutar.
  List<SlotGroup> get slotGroups {
    final groups = <SlotGroup>[];
    var start = 0;
    for (final stage in stages ?? [TaskStage('', steps.length)]) {
      groups.add(SlotGroup(stage.title, [for (var i = 0; i < stage.size; i++) start + i]));
      start += stage.size;
    }
    return groups;
  }
}

/// Ekranda birlikte gösterilen kutular. Başlık boşsa aşama başlığı çizilmez.
final class SlotGroup {
  const SlotGroup(this.title, this.slots);

  final String title;
  final List<int> slots;
}
