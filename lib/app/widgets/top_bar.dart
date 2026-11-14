import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/play/widgets/image_button.dart';
import '../app_assets.dart';
import '../app_texts.dart';
import '../app_theme.dart';
import '../screen_scale.dart';

/// İç ekranların üst çubuğu (web sürümündeki `topBar`): solda yuvarlak geri düğmesi, ortada beyaz
/// panelde başlık, sağda ekrana özgü öğeler. Geniş ekranda başlık sayfanın ortasında durur; ortaya
/// sığmazsa iki yanın arasına ortalanır. Dar ekranda başlık iki yanın arasını doldurur.
/// [dense] oyun ekranındaki daha sıkı çubuktur; harita için yer açar. [showHome] geri düğmesinin
/// yanına, araya giren bütün ekranları kapatıp ana ekrana dönen bir düğme ekler.
final class TopBar extends StatelessWidget {
  const TopBar({
    required this.title,
    required this.backLabel,
    this.icon,
    this.actions = const [],
    this.dense = false,
    this.showHome = false,
    super.key,
  });

  final String title;
  final String backLabel;
  final String? icon;
  final List<Widget> actions;
  final bool dense;
  final bool showHome;

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
    final gap = narrow ? _narrowGap : _gap;
    final navigator = Navigator.of(context);
    return Padding(
      padding: _padding.copyWith(bottom: AppMetrics.lip),
      child: SizedBox(
        height: height,
        child: CustomMultiChildLayout(
          delegate: _TopBarLayout(gap: gap, centered: !narrow),
          children: [
            LayoutId(
              id: _Slot.leading,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: gap,
                children: [
                  ImageButton(asset: AppAssets.back, label: backLabel, size: button, onPressed: navigator.maybePop),
                  if (showHome)
                    ImageButton(
                      asset: AppAssets.home,
                      label: AppTexts.backToHome,
                      size: button,
                      onPressed: () => navigator.popUntil((route) => route.isFirst),
                    ),
                ],
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

enum _Slot { leading, title, actions }

/// Geri (ve ana ekran) düğmesini sola, öğeleri sağa, başlığı ortaya yerleştirir; hepsi dikeyde ortalanır.
final class _TopBarLayout extends MultiChildLayoutDelegate {
  _TopBarLayout({required this.gap, required this.centered});

  final double gap;
  final bool centered;

  @override
  void performLayout(Size size) {
    final loose = BoxConstraints.loose(size);
    final leading = layoutChild(_Slot.leading, loose);
    final actions = layoutChild(_Slot.actions, loose);
    final left = leading.width + gap;
    final between = max(0.0, size.width - left - actions.width - gap);
    final title = layoutChild(
      _Slot.title,
      BoxConstraints(minWidth: centered ? 0 : between, maxWidth: between, maxHeight: size.height),
    );
    final pageCenter = (size.width - title.width) / 2;
    final fitsPageCenter = pageCenter >= left && pageCenter + title.width <= left + between;
    final x = centered && fitsPageCenter ? pageCenter : left + (between - title.width) / 2;
    positionChild(_Slot.leading, Offset(0, (size.height - leading.height) / 2));
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
  static const _radius = BorderRadius.all(Radius.circular(AppMetrics.mediumRadius));

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
    return CustomPaint(
      painter: const _LipPainter(),
      child: Container(
        padding: _padding,
        decoration: const BoxDecoration(color: AppColors.panel, borderRadius: _radius),
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
      ),
    );
  }
}

/// Panelin altındaki kalın gölge (web sürümündeki `box-shadow: 0 lip`). Panel yarı saydam olduğu için
/// gölge yalnızca panelin altından taşan kısma çizilir; yoksa panelin içinden görünüp onu lekeler.
final class _LipPainter extends CustomPainter {
  const _LipPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final panel = _TitlePanel._radius.toRRect(Offset.zero & size);
    final lip = Path.combine(
      PathOperation.difference,
      Path()..addRRect(panel.shift(const Offset(0, AppMetrics.lip))),
      Path()..addRRect(panel),
    );
    canvas.drawPath(lip, Paint()..color = AppColors.shadow);
  }

  @override
  bool shouldRepaint(_LipPainter oldDelegate) => false;
}
