import 'package:flutter/foundation.dart';

import '../../l10n/l10n.dart';
import 'engine/repeat_program.dart';
import 'program_editor.dart';
import 'program_models.dart';
import 'program_runner.dart';

/// Tek blok şeridi düzenlenen oyunların ("Tekrar Et", "Değişken Kutusu", "Desen Bulmacası" Uzman grubu) ortak
/// düzenleme eylemleri: blok ekleme, Tekrarla düğmesi, tekrar sayısı, seçim, silme ve bloktan çıkarma. Her
/// değişiklikte robot başa döner.
mixin ProgramEditing on ProgramRunner implements ProgramStripModel, ProgramControlsModel {
  /// Şeridin blokları; denetleyici kendi düzenleyicisini verir.
  @protected
  ProgramEditor get editor;

  @override
  List<ProgramBlock> get program => editor.program;
  @override
  int get blockCount => editor.blockCount;
  @override
  bool get isFull => blockCount >= maxBlocks;
  @override
  int? get target => editor.target;
  @override
  bool get isInsideRepeat => target != null;
  @override
  ProgramPlace? get selected => editor.selected;

  bool get canAddInner => !isRunning && !isFull;

  /// Tekrar bloğu açılınca söylenen metin; oklar yerine başka bloklar eklenen oyun kendi metnini verir.
  @protected
  LocalizedText get insideRepeatText =>
      (t) => t.repeatInsideRepeat;

  /// Tekrar bloğundan çıkılınca söylenen metin.
  @protected
  LocalizedText get outsideRepeatText =>
      (t) => t.repeatOutsideRepeat;

  /// Seçili blok tekrar bloğunun dışına taşınınca söylenen metin.
  @protected
  LocalizedText get movedOutText =>
      (t) => t.repeatMovedOut;

  /// Bloğu (ör. kutu ya da "renk yak" bloğu) açık tekrar bloğunun içine, yoksa programın sonuna ekler.
  void addInner(InnerBlock block) {
    if (!canAddInner) {
      return;
    }
    changeProgram(() => editor.appendInner(block));
    if (isFull) {
      voice.say((t) => t.repeatFull);
    }
    notifyListeners();
  }

  /// Tekrarla düğmesi: blok açıksa bloktan çıkar, değilse yeni bir tekrar bloğu ekleyip açar.
  @override
  void pressRepeatButton() {
    if (!canUseRepeatButton) {
      return;
    }
    if (target != null) {
      editor.closeTarget();
      voice.say(outsideRepeatText);
      notifyListeners();
      return;
    }
    changeProgram(() => editor.appendBlock(const RepeatBlock(RepeatBlock.defaultTimes, [])));
    voice.say(isFull ? (t) => t.repeatFull : insideRepeatText);
    notifyListeners();
  }

  /// Tekrar sayısını bir azaltır (-1) ya da artırır (+1); sayı sınırlar içinde kalır.
  @override
  void changeTimes(int index, int offset) {
    if (!isRunning && program[index] is RepeatBlock) {
      changeProgram(() => editor.changeTimes(index, offset));
      notifyListeners();
    }
  }

  /// Tekrar bloğunun etiketine dokunulunca blok açılır (bloklar içine eklenir) ya da kapanır.
  @override
  void toggleTarget(int index) {
    if (isRunning) {
      return;
    }
    final leaving = editor.toggleTarget(index);
    voice.say(leaving ? outsideRepeatText : insideRepeatText);
    notifyListeners();
  }

  @override
  void clearSelection() {
    if (editor.clearSelection()) {
      notifyListeners();
    }
  }

  @override
  void deleteSelected() {
    if (!isRunning && selected != null) {
      changeProgram(editor.deleteSelected);
      notifyListeners();
    }
  }

  /// Bloğun içindeki seçili bloğu bloğun hemen arkasına taşır; sonraki bloklar da dışarıya eklenir.
  @override
  void moveSelectedOut() {
    final place = selected;
    if (isRunning || place == null || !Places.isInner(place)) {
      return;
    }
    changeProgram(editor.moveSelectedOut);
    voice.say(movedOutText);
    notifyListeners();
  }

  /// Bloklar değişince robot başa döner, eski ipucu ve işaretler silinir.
  @protected
  void changeProgram(VoidCallback update) {
    update();
    editor.clearSelection();
    resetBoard();
  }
}
