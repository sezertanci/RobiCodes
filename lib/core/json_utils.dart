import 'dart:convert';

/// Kayıttan okunan JSON metnini nesneye çevirir. Metin yoksa, bozuksa veya beklenen
/// biçimde değilse `null` döner; böylece bozuk bir kayıt uygulamayı çökertmez.
Map<String, Object?>? decodeJsonObject(String? raw) {
  if (raw == null) {
    return null;
  }
  try {
    final decoded = jsonDecode(raw);
    return decoded is Map<String, Object?> ? decoded : null;
  } on FormatException {
    return null;
  }
}
