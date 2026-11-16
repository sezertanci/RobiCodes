import '../path_finder/engine/path_finder_board.dart';
import '../path_finder/engine/path_finder_engine.dart';
import 'engine/repeat_program.dart';

/// Bir blok şeridinin ([ProgramStrip]) okuduğu durum ve dokunuşlarda çağırdığı eylemler.
/// "Tekrar Et" denetleyicisi bunu doğrudan, "Kendi Komutunu Oluştur" her şeridi için ayrı uygular.
abstract interface class ProgramStripModel {
  List<ProgramBlock> get program;
  int get blockCount;
  int get maxBlocks;
  bool get isFull;
  bool get isRunning;

  /// Okların içine eklendiği (açık) tekrar bloğunun sırası.
  int? get target;
  ProgramPlace? get selected;

  /// Çalışırken bu şeritteki o anki hareketin yeri ve turu.
  ProgramStep? get activeStep;

  /// Robotu yoldan çıkaran yer (kırmızıyla gösterilir).
  ProgramPlace? get wrongPlace;

  /// Hazır programı düzeltme kuralları geçerli mi ("Önüne ekle" düğmesi görünür).
  bool get fixesProgram;
  bool get isInserting;
  bool get canInsert;

  void toggleSelection(ProgramPlace place);
  void clearSelection();
  void deleteSelected();
  void moveSelectedOut();
  void toggleInserting();
  void changeTimes(int index, int offset);

  /// "kutu = N" bloğunun sayısını bir azaltır (-1) ya da artırır (+1).
  void changeBoxValue(ProgramPlace place, int offset);
  void toggleTarget(int index);
}

/// Yön tuşları ve oyun düğmelerinin ([RepeatControls]) okuduğu durum ve eylemler.
abstract interface class ProgramControlsModel {
  bool get isRunning;
  bool get canAddMove;

  /// İpucunun parlattığı yön tuşu.
  NextMoveHint? get hint;
  bool get fixesProgram;

  /// Tekrarla düğmesi gösterilir mi.
  bool get allowsRepeat;

  /// Bir tekrar bloğu açık mı (Tekrarla düğmesi "Bloktan çık" olur).
  bool get isInsideRepeat;
  bool get canUseRepeatButton;

  void addMove(Direction direction);
  void pressRepeatButton();
  Future<void> run();
  void showHint();
  void clear();
}
