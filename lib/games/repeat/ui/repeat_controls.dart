import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_theme.dart';
import '../../../features/play/widgets/image_button.dart';
import '../../path_finder/ui/direction_pad.dart';
import '../../../l10n/l10n.dart';
import '../program_models.dart';
import '../repeat_texts.dart';
import 'program_strip.dart';
import 'repeat_block_view.dart';

/// Yön tuşları, Tekrarla düğmesi ile Başlat, İpucu ve Temizle düğmeleri. Hazır programı düzeltme
/// kurallarında Temizle "Baştan al" olur; Tekrarla düğmesi yalnızca seviye izin veriyorsa görünür.
/// Geniş ekranda düğmeler yön tuşlarının altında durur: üstte tam satır Tekrarla, altında üç düğme.
/// Dar ekranda yön tuşlarının sağında Tekrarla üstte, Başlat ile İpucu ortada, Temizle altta durur.
/// [commandButton] verilirse (ör. "Komut") Tekrarla'nın üstünde aynı genişlikte bir satır daha olur.
final class RepeatControls extends StatelessWidget {
  const RepeatControls({
    required this.controller,
    required this.buttonSize,
    required this.stacked,
    this.commandButton,
    super.key,
  });

  final ProgramControlsModel controller;
  final double buttonSize;

  /// `true` ise düğmeler yön tuşlarının altında dizilir.
  final bool stacked;

  /// Verilen genişlik ve yükseklikte geniş bir düğme çizer.
  final Widget Function(double width, double height)? commandButton;

  static const _stackedGap = 16.0;
  static const _rowGap = 24.0;

  /// Tekrarla düğmesinin yüksekliğinin düğme boyuna oranı.
  static const _repeatHeightRatio = 0.8;

  /// Alt alta düzende düğme boyunda satır sayısı: yön tuşlarının üç satırı ve eylem düğmeleri.
  static const _stackedRows = 4;

  /// Dar ekranın sağ sütununda Başlat/İpucu ve Temizle satırları.
  static const _actionRows = 2;

  /// Alt alta düzenin [height] yüksekliğe sığması için düğme boyu. [wideRows], Tekrarla gibi geniş
  /// düğmelerin satır sayısıdır; yer her zaman en az bir geniş satır için ayrılır.
  static double stackedButtonSizeFor(double height, {int wideRows = 1}) =>
      (height - _stackedGap - ImageButton.padding * 2 * (_stackedRows + wideRows)) /
      (_stackedRows + _repeatHeightRatio * wideRows);

  /// Yan yana düzenin verilen düğme boyundaki yüksekliği: yön tuşları ya da sağdaki sütun, hangisi uzunsa.
  static double rowHeight(double buttonSize, {int wideRows = 1}) => max(
    DirectionPad.extent(buttonSize),
    _wideHeight(buttonSize) * wideRows + (buttonSize + ImageButton.padding * 2) * _actionRows,
  );

  static double _wideHeight(double buttonSize) => buttonSize * _repeatHeightRatio + ImageButton.padding * 2;

  /// Alt alta düzenin verilen düğme boyundaki genişliği.
  static double stackedWidth(double buttonSize) => DirectionPad.extent(buttonSize);

  double get _cell => buttonSize + ImageButton.padding * 2;

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final pad = TapRegion(
      groupId: ProgramStrip.tapGroup,
      child: DirectionPad(
        buttonSize: buttonSize,
        enabled: controller.canAddMove,
        highlighted: controller.hint?.direction,
        label: (direction) => RepeatTexts.addMove(t, direction),
        onPressed: controller.addMove,
      ),
    );
    final run = _action(AppAssets.runButton, t.commonRun, controller.run);
    final hint = _action(AppAssets.hintButton, t.commonHint, controller.showHint);
    final clearLabel = controller.fixesProgram ? t.bugHunterReset : t.commonClear;
    final clear = _action(AppAssets.clearButton, clearLabel, controller.clear);
    if (stacked) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          pad,
          const SizedBox(height: _stackedGap),
          if (commandButton case final button?) _wideButton(button, columns: DirectionPad.gridSize),
          if (controller.allowsRepeat) _repeatButton(columns: DirectionPad.gridSize),
          Row(mainAxisSize: MainAxisSize.min, children: [run, hint, clear]),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        pad,
        const SizedBox(width: _rowGap),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (commandButton case final button?) _wideButton(button, columns: 2),
            if (controller.allowsRepeat) _repeatButton(columns: 2),
            Row(mainAxisSize: MainAxisSize.min, children: [run, hint]),
            clear,
          ],
        ),
      ],
    );
  }

  Widget _action(String asset, String label, VoidCallback onPressed) =>
      ImageButton(asset: asset, label: label, size: buttonSize, onPressed: controller.isRunning ? null : onPressed);

  Widget _repeatButton({required int columns}) => _wideButton(
    (width, height) => RepeatButton(
      leaving: controller.isInsideRepeat,
      width: width,
      height: height,
      onPressed: controller.canUseRepeatButton ? controller.pressRepeatButton : null,
    ),
    columns: columns,
  );

  Widget _wideButton(Widget Function(double width, double height) build, {required int columns}) => Padding(
    padding: const EdgeInsets.all(ImageButton.padding),
    child: build(_cell * columns - ImageButton.padding * 2, buttonSize * _repeatHeightRatio),
  );
}

/// Turuncu "Tekrarla" düğmesi. Blok açıkken lacivert "Bloktan çık" olur ve döngü simgesi gizlenir;
/// böylece yeşil Başlat ve mavi yön tuşlarıyla karışmaz.
final class RepeatButton extends StatelessWidget {
  const RepeatButton({
    required this.leaving,
    required this.width,
    required this.height,
    required this.onPressed,
    super.key,
  });

  final bool leaving;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  static const _navyDark = Color(0xFF111A30);

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    return WideActionButton(
      tone: leaving ? const ColorTone(AppColors.navy, _navyDark) : AppTones.orange,
      icon: leaving ? null : RepeatIcon(size: height * WideActionButton.iconRatio),
      text: leaving ? t.repeatLeaveRepeat : t.repeatAddRepeat,
      label: leaving ? t.repeatLeaveRepeatLabel : t.repeatAddRepeatLabel,
      width: width,
      height: height,
      onPressed: onPressed,
    );
  }
}

/// Renkli, kabarık kenarlı geniş düğme: solda isteğe bağlı simge, yanında kalın beyaz yazı.
/// Tekrarla ve Komut düğmeleri ortak kullanır. [iconAbove] ise simge yazının üstünde durur; dar
/// düğmelerde (ör. yan yana üç kutu düğmesi) yazı böylece küçülmeden sığar.
final class WideActionButton extends StatelessWidget {
  const WideActionButton({
    required this.tone,
    required this.text,
    required this.label,
    required this.width,
    required this.height,
    required this.onPressed,
    this.icon,
    this.iconAbove = false,
    super.key,
  });

  final ColorTone tone;
  final Widget? icon;
  final bool iconAbove;
  final String text;

  /// Ekran okuyucu etiketi.
  final String label;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  /// Simgenin düğme yüksekliğine oranı.
  static const iconRatio = 0.6;

  /// Simge yazının üstündeyken yüksekliğe oranı; simge ile yazı birlikte düğmeye sığar.
  static const iconAboveRatio = 0.4;
  static const _textRatio = 0.36;
  static const _disabledOpacity = 0.4;
  static const _padding = 12.0;
  static const _iconAbovePadding = 4.0;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: onPressed != null,
    label: label,
    excludeSemantics: true,
    onTap: onPressed,
    child: Opacity(
      opacity: onPressed == null ? _disabledOpacity : 1,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(horizontal: iconAbove ? _iconAbovePadding : _padding, vertical: 6),
          decoration: BoxDecoration(
            color: tone.base,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: tone.dark, offset: const Offset(0, 4))],
          ),
          child: FittedBox(child: _content()),
        ),
      ),
    ),
  );

  Widget _content() {
    final label = Text(
      text,
      style: TextStyle(
        fontSize: height * _textRatio,
        fontWeight: FontWeight.w900,
        color: Colors.white,
        shadows: [Shadow(color: tone.dark, offset: const Offset(0, 2))],
      ),
    );
    final icon = this.icon;
    if (icon == null) {
      return label;
    }
    if (iconAbove) {
      return Column(mainAxisSize: MainAxisSize.min, children: [icon, label]);
    }
    return Row(mainAxisSize: MainAxisSize.min, children: [icon, const SizedBox(width: 8), label]);
  }
}
