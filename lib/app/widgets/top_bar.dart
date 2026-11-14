import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/play/widgets/image_button.dart';
import '../app_assets.dart';
import '../app_theme.dart';
import '../screen_scale.dart';

/// İç ekranların üst çubuğu (web sürümündeki `topBar`): solda yuvarlak geri düğmesi, ortada beyaz
/// panelde başlık, sağda ekrana özgü öğeler. Geniş ekranda başlık sayfanın ortasında durur; ortaya
/// sığmazsa iki yanın arasına ortalanır. Dar ekranda başlık iki yanın arasını doldurur.
/// [dense] oyun ekranındaki daha sıkı çubuktur; harita için yer açar.
final class TopBar extends StatelessWidget {
  const TopBar({
    required this.title,
    required this.backLabel,
    this.icon,
    this.actions = const [],
    this.dense = false,
    super.key,
  });

  final String title;
  final String backLabel;
  final String? icon;
  final List<Widget> actions;
  final bool dense;

  static const _padding = EdgeInsets.fromLTRB(16, 8, 16, 0);
  static const _gap = 12.0;
  static const _narrowGap = 8.0;
  static const _denseButton = 52.0;

  @override
  Widget build(BuildContext context) {
    final narrow = ScreenScale.isNarrow(context);
    final button = dense ? _denseButton : (narrow ? AppMetrics.compactTouch : AppMetrics.touch);
    final panel = _TitlePanel(title: title, icon: icon, dense: dense, narrow: narrow);
    final height = max(button + 2 * ImageButton.padding, panel.height);
    return Padding(
      padding: _padding.copyWith(bottom: AppMetrics.lip),
      child: SizedBox(
        height: height,
        child: CustomMultiChildLayout(
          delegate: _TopBarLayout(gap: narrow ? _narrowGap : _gap, centered: !narrow),
          children: [
            LayoutId(
              id: _Slot.back,
              child: ImageButton(
                asset: AppAssets.back,
                label: backLabel,
                size: button,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
            LayoutId(id: _Slot.title, child: panel),
            LayoutId(
              id: _Slot.actions,
              child: Row(mainAxisSize: MainAxisSize.min, children: actions),
            ),
          ],
        ),
      ),
    );
  }
}

enum _Slot { back, title, actions }

/// Geri düğmesini sola, öğeleri sağa, başlığı ortaya yerleştirir; hepsi dikeyde ortalanır.
final class _TopBarLayout extends MultiChildLayoutDelegate {
  _TopBarLayout({required this.gap, required this.centered});

  final double gap;
  final bool centered;

  @override
  void performLayout(Size size) {
    final loose = BoxConstraints.loose(size);
    final back = layoutChild(_Slot.back, loose);
    final actions = layoutChild(_Slot.actions, loose);
    final left = back.width + gap;
    final between = max(0.0, size.width - left - actions.width - gap);
    final title = layoutChild(
      _Slot.title,
      BoxConstraints(minWidth: centered ? 0 : between, maxWidth: between, maxHeight: size.height),
    );
    final pageCenter = (size.width - title.width) / 2;
    final fitsPageCenter = pageCenter >= left && pageCenter + title.width <= left + between;
    final x = centered && fitsPageCenter ? pageCenter : left + (between - title.width) / 2;
    positionChild(_Slot.back, Offset(0, (size.height - back.height) / 2));
    positionChild(_Slot.actions, Offset(size.width - actions.width, (size.height - actions.height) / 2));
    positionChild(_Slot.title, Offset(x, (size.height - title.height) / 2));
  }

  @override
  bool shouldRelayout(_TopBarLayout oldDelegate) => oldDelegate.gap != gap || oldDelegate.centered != centered;
}

/// Beyaz panelde ikon ve başlık (web sürümündeki `.top-bar-title`).
final class _TitlePanel extends StatelessWidget {
  const _TitlePanel({required this.title, required this.icon, required this.dense, required this.narrow});

  final String title;
  final String? icon;
  final bool dense;
  final bool narrow;

  static const _iconSize = 44.0;
  static const _denseIconSize = 36.0;
  static const _narrowIconSize = 32.0;
  static const _gap = 10.0;
  static const _narrowGap = 6.0;
  static const _narrowDenseFontSize = 18.0;

  double get _iconExtent => narrow ? _narrowIconSize : (dense ? _denseIconSize : _iconSize);

  EdgeInsets get _padding =>
      EdgeInsets.symmetric(horizontal: narrow ? 12 : (dense ? 18 : 24), vertical: dense ? 4 : (narrow ? 6 : 8));

  /// Panelin ikonla birlikte yüksekliği; çubuğun yüksekliği buna göre seçilir.
  double get height => _iconExtent + _padding.vertical;

  @override
  Widget build(BuildContext context) {
    final icon = this.icon;
    final fontSize = switch ((dense, narrow)) {
      (true, true) => _narrowDenseFontSize,
      (true, false) => ScreenScale.fluid(context, 20, 0.03, 28),
      _ => ScreenScale.fluid(context, 22, 0.04, 34),
    };
    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(AppMetrics.mediumRadius),
        boxShadow: const [BoxShadow(color: AppColors.shadow, offset: Offset(0, AppMetrics.lip))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            SvgPicture.asset(icon, width: _iconExtent, height: _iconExtent),
            SizedBox(width: narrow ? _narrowGap : _gap),
          ],
          Flexible(
            child: Semantics(
              header: true,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppColors.navy, fontSize: fontSize, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
