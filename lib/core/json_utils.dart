import 'dart:convert';

/// Kayıttan okunan JSON metnini nesneye çevirir. Metin yoksa, bozuksa veya beklenen
/// biçimde değilse `null` döner; böylece bozuk bir kayıt uygulamayı çökertmez.
Map<String, Object?>? decodeJsonObject(String? raw) => _decode<Map<String, Object?>>(raw);

/// Kayıttan okunan JSON metnini listeye çevirir; [decodeJsonObject] gibi hatalı kayıtta `null` döner.
List<Object?>? decodeJsonList(String? raw) => _decode<List<Object?>>(raw);

T? _decode<T>(String? raw) {
  if (raw == null) {
    return null;
  }
  try {
    final decoded = jsonDecode(raw);
    return decoded is T ? decoded : null;
  } on FormatException {
    return null;
  }
}
