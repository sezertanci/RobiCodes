import 'package:flutter/foundation.dart';

import '../../core/storage/key_value_store.dart';
import '../../core/storage/storage_keys.dart';
import '../parental_gate/parental_gate.dart';
import '../parental_gate/protected_action_runner.dart';
import '../progress/progress_repository.dart';
import '../progress/progress_snapshot.dart';
import 'cloud_save_gateway.dart';
import 'progress_merger.dart';

/// Eşitlemenin sonucu.
enum CloudSyncResult {
  /// Kayıtlar birleştirildi; cihaz ve bulut aynı.
  synced,

  /// Bulut eşitleme kapalı.
  disabled,

  /// Hesaba bağlı değil.
  notSignedIn,

  /// Buluta ulaşılamadı; cihazdaki kayıt değişmedi.
  unavailable,
}

/// İsteğe bağlı bulut eşitlemesi. Kapalıyken uygulama yalnızca cihazdaki kayıtla çalışır.
/// Açma ve kapatma kararı ebeveyn doğrulamasının arkasındadır (bkz. `ProtectedActionRunner`);
/// bu servis yalnızca bayrağı ve eşitlemeyi yönetir.
final class CloudSyncService extends ChangeNotifier {
  CloudSyncService({required this._gateway, required this._progress, required KeyValueStore store})
    : _store = store,
      _enabled = store.read(StorageKeys.cloudSync) == _enabledValue;

  static const _enabledValue = 'on';

  final CloudSaveGateway _gateway;
  final ProgressRepository _progress;
  final KeyValueStore _store;
  bool _enabled;

  bool get isEnabled => _enabled;

  /// Eşitlemeyi açar veya kapatır. [approval], istenen yön için (açma veya kapatma) geçerli ve
  /// kullanılmamış bir ebeveyn onayı olmalıdır; değilse hiçbir şey değişmez ve `false` döner.
  Future<bool> setEnabled({required bool enabled, required ParentalApproval approval}) async {
    if (!approval.consume(enabled ? ParentalAction.enableCloudSync : ParentalAction.disableCloudSync)) {
      return false;
    }
    if (_enabled == enabled) {
      return true;
    }
    _enabled = enabled;
    notifyListeners();
    await (enabled ? _store.write(StorageKeys.cloudSync, _enabledValue) : _store.remove(StorageKeys.cloudSync));
    return true;
  }

  /// Buluttaki kaydı okur, cihazdakiyle birleştirir ve sonucu iki yere de yazar.
  Future<CloudSyncResult> sync() async {
    if (!_enabled) {
      return CloudSyncResult.disabled;
    }
    if (!await _gateway.isSignedIn()) {
      return CloudSyncResult.notSignedIn;
    }
    final remote = await _gateway.load();
    if (remote == null) {
      return CloudSyncResult.unavailable;
    }
    final merged = ProgressMerger.merge(_progress.snapshot, ProgressSnapshot.fromJson(remote));
    await _progress.replace(merged);
    return await _gateway.save(merged.toJson()) ? CloudSyncResult.synced : CloudSyncResult.unavailable;
  }
}
