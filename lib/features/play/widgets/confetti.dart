import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

/// Konfetinin tek bir parçası. Değerler web sürümündeki `confetti()` ile aynı formülle sıradan hesaplanır;
/// böylece her açılışta aynı, düzenli dağılmış bir yağmur oluşur.
@immutable
final class ConfettiPiece {
  const ConfettiPiece._({
    required this.left,
    required this.delay,
    required this.turns,
    required this.color,
    required this.isRound,
  });

  factory ConfettiPiece.at(int index) {
    final shape = index % _colors.length;
    return ConfettiPiece._(
      left: (index * _leftStep % _percent) / _percent,
      delay: _delayStep * (index % _delayGroups),
      turns: (index.isOdd ? 1 : -1) * _turnsPerFall,
      color: _colors[shape],
      isRound: shape == _roundShape,
    );
  }

  static const _leftStep = 37;
  static const _percent = 100;
  static const _delayGroups = 7;
  static const _delayStep = Duration(milliseconds: 180);

  /// Düşüş boyunca dönüş: 540 derece, yani bir buçuk tur.
  static const _turnsPerFall = 1.5;

  static const _colors = [AppColors.blue, AppColors.green, AppColors.red, AppColors.purple, AppColors.yellow];
  static const _roundShape = 3;

  /// Parçanın sol kenarının alan genişliğine oranı (0–1).
  final double left;
  final Duration delay;

  /// Düşüş bitene kadar yapılan tur sayısı; eksi değer ters yöne döner.
  final double turns;
  final Color color;

  /// Mor parçalar yuvarlak, diğerleri dikdörtgendir.
  final bool isRound;

  Size get size => isRound ? const Size.square(10) : const Size(12, 18);
}

/// Bulunduğu alanın tamamına bir kez yağan konfeti. Dokunmaları engellemez, ekran okuyucuya görünmez.
/// "Hareketi azalt" açıksa hiç gösterilmez.
final class Confetti extends StatefulWidget {
  const Confetti({super.key});

  static const pieceCount = 28;
  static const fallDuration = Duration(milliseconds: 3200);

  /// Son parçanın da düşüşü bitene kadar geçen süre.
  static final totalDuration = fallDuration + ConfettiPiece.at(_slowestIndex).delay;
  static const _slowestIndex = ConfettiPiece._delayGroups - 1;

  @override
  State<Confetti> createState() => _ConfettiState();
}

final class _ConfettiState extends State<Confetti> with SingleTickerProviderStateMixin {
  static final _pieces = List.generate(Confetti.pieceCount, ConfettiPiece.at, growable: false);

  late final AnimationController _controller = AnimationController(vsync: this, duration: Confetti.totalDuration)
    ..addStatusListener((status) {
      if (status.isCompleted) {
        setState(() {});
      }
    })
    ..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context) || _controller.isCompleted) {
      return const SizedBox.shrink();
    }
    return IgnorePointer(
      child: ExcludeSemantics(
        child: CustomPaint(size: Size.infinite, painter: _ConfettiPainter(_controller, _pieces)),
      ),
    );
  }
}

final class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this._clock, this._pieces) : super(repaint: _clock);

  /// Parçalar ekranın biraz üstünden başlar ve ekran yüksekliğinin %110'u kadar düşer.
  static const _startTop = -24.0;
  static const _fallFactor = 1.1;
  static const _cornerRadius = Radius.circular(3);

  final Animation<double> _clock;
  final List<ConfettiPiece> _pieces;

  @override
  void paint(Canvas canvas, Size size) {
    final elapsed = Confetti.totalDuration * _clock.value;
    final paint = Paint();
    for (final piece in _pieces) {
      final progress = (elapsed - piece.delay).inMicroseconds / Confetti.fallDuration.inMicroseconds;
      if (progress <= 0 || progress >= 1) {
        continue;
      }
      final pieceSize = piece.size;
      final center = Offset(
        piece.left * size.width + pieceSize.width / 2,
        _startTop + progress * size.height * _fallFactor + pieceSize.height / 2,
      );
      canvas
        ..save()
        ..translate(center.dx, center.dy)
        ..rotate(progress * piece.turns * 2 * math.pi);
      final rect = Rect.fromCenter(center: Offset.zero, width: pieceSize.width, height: pieceSize.height);
      paint.color = piece.color;
      if (piece.isRound) {
        canvas.drawOval(rect, paint);
      } else {
        canvas.drawRRect(RRect.fromRectAndRadius(rect, _cornerRadius), paint);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter oldDelegate) => false;
}
