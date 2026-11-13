import 'dart:math';

import 'package:flutter/widgets.dart';

import '../../content/catalog_data.dart';
import '../game_module.dart';
import 'engine/command_order_engine.dart';
import 'engine/command_order_level.dart';
import 'engine/command_order_levels.dart';
import 'ui/command_order_view.dart';

/// "Komutları Sırala" oyun modülü. Seviyeler paket kimliğine göre bulunur. Kartlar her açılışta
/// yeniden karıştırılır; aynı seviye art arda aynı sırayla açılmaz.
final class CommandOrderModule implements GameModule {
  CommandOrderModule({Map<String, List<CommandOrderLevel>>? packs, int Function()? seedSource})
    : packs = packs ?? {basePackId(GameIds.commandOrder): commandOrderBaseLevels},
      _seedSource = seedSource ?? (() => Random().nextInt(CommandOrderEngine.lcgModulus));

  /// Paket kimliği → seviyeler (1. seviye listenin ilk elemanıdır).
  final Map<String, List<CommandOrderLevel>> packs;
  final int Function() _seedSource;

  /// "paket/seviye" → son açılıştaki kart sırası.
  final Map<String, List<int>> _lastOrders = {};

  @override
  String get gameId => GameIds.commandOrder;

  CommandOrderLevel levelOf(String packId, int level) {
    final levels = packs[packId];
    if (levels == null || level < 1 || level > levels.length) {
      throw ArgumentError('Bilinmeyen seviye: $packId / $level');
    }
    return levels[level - 1];
  }

  /// Seviyenin kartlarını karıştırır; bir önceki açılıştaki sıradan kaçınır.
  List<OrderCard> shuffledCards(String packId, int level) {
    final key = '$packId/$level';
    final cards = CommandOrderEngine.shuffleCards(
      CommandOrderEngine.buildCards(levelOf(packId, level)),
      _seedSource(),
      _lastOrders[key] ?? const [],
    );
    _lastOrders[key] = [for (final card in cards) card.id];
    return cards;
  }

  @override
  Widget buildLevel(LevelSession session) => CommandOrderView(
    level: levelOf(session.packId, session.level),
    // Kartlar ekran açılırken bir kez karıştırılır; ekranın yeniden çizilmesi sırayı değiştirmez.
    shuffle: () => shuffledCards(session.packId, session.level),
    onCompleted: session.onCompleted,
  );
}
