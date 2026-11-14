import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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

/// Bulunduğu alanın tamamına yağan konfeti: varsayılan olarak bir kez, [loops] açıksa durmadan
/// (kupa penceresinde olduğu gibi). Dokunmaları engellemez, ekran okuyucuya görünmez.
/// "Hareketi azalt" açıksa hiç gösterilmez.
final class Confetti extends StatefulWidget {
  const Confetti({this.loops = false, super.key});

  static const pieceCount = 28;
  static const fallDuration = Duration(milliseconds: 3200);

  /// Son parçanın da düşüşü bitene kadar geçen süre.
  static final totalDuration = fallDuration + ConfettiPiece.at(_slowestIndex).delay;
  static const _slowestIndex = ConfettiPiece._delayGroups - 1;

  /// Her parça düşüşünü bitirince en üstten yeniden başlar.
  final bool loops;

  @override
  State<Confetti> createState() => _ConfettiState();
}

final class _ConfettiState extends State<Confetti> with SingleTickerProviderStateMixin {
  static final _pieces = List.generate(Confetti.pieceCount, ConfettiPiece.at, growable: false);

  /// Yağmurun başlangıcından beri geçen süre.
  final _elapsed = ValueNotifier(Duration.zero);
  late final Ticker _ticker;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    _elapsed.value = elapsed;
    if (!widget.loops && elapsed >= Confetti.totalDuration) {
      _ticker.stop();
      setState(() => _isFinished = true);
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _elapsed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context) || _isFinished) {
      return const SizedBox.shrink();
    }
    return IgnorePointer(
      child: ExcludeSemantics(
        child: CustomPaint(
          size: Size.infinite,
          painter: _ConfettiPainter(_elapsed, _pieces, loops: widget.loops),
        ),
      ),
    );
  }
}

final class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this._elapsed, this._pieces, {required this.loops}) : super(repaint: _elapsed);

  /// Parçalar ekranın biraz üstünden başlar ve ekran yüksekliğinin %110'u kadar düşer.
  static const _startTop = -24.0;
  static const _fallFactor = 1.1;
  static const _cornerRadius = Radius.circular(3);

  final ValueListenable<Duration> _elapsed;
  final List<ConfettiPiece> _pieces;
  final bool loops;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (final piece in _pieces) {
      final fallen = (_elapsed.value - piece.delay).inMicroseconds;
      final fall = Confetti.fallDuration.inMicroseconds;
      // Döngüde parça düşüşünü bitirince en üstten yeniden başlar; gecikmesi dolmadan görünmez.
      final progress = (loops && fallen > 0 ? fallen % fall : fallen) / fall;
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
