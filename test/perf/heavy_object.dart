import 'package:meta/meta.dart';

/// A heavy object that's expensive to hash
@immutable
class HeavyObject {
  final String id;
  final List<String> tags;
  final Map<String, dynamic> metadata;
  final List<int> largeData;
  final DateTime createdAt;
  final HeavyObject? nestedObject;

  const HeavyObject({
    required this.id,
    required this.tags,
    required this.metadata,
    required this.largeData,
    required this.createdAt,
    this.nestedObject,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeavyObject &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          _listEquals(tags, other.tags) &&
          _mapEquals(metadata, other.metadata) &&
          _listEquals(largeData, other.largeData) &&
          createdAt == other.createdAt &&
          nestedObject == other.nestedObject;

  @override
  int get hashCode {
    // Expensive hash computation that considers all fields
    var result = id.hashCode;
    result = 31 * result + _hashList(tags);
    result = 31 * result + _hashMap(metadata);
    result = 31 * result + _hashList(largeData);
    result = 31 * result + createdAt.hashCode;
    result = 31 * result + (nestedObject?.hashCode ?? 0);
    return result;
  }

  // Expensive toString that serializes the entire object
  @override
  String toString() =>
      'HeavyObject{'
      'id: $id, '
      'tags: $tags, '
      'metadata: $metadata, '
      'largeData: ${largeData.length} bytes, '
      'createdAt: $createdAt, '
      'nestedObject: $nestedObject'
      '}';

  // Helper methods for deep equality and hashing
  static bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == b) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  static bool _mapEquals<K, V>(Map<K, V>? a, Map<K, V>? b) {
    if (a == b) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }

    return true;
  }

  static int _hashList<T>(List<T> list) {
    var hash = 0;
    for (final item in list) {
      hash = 31 * hash + (item?.hashCode ?? 0);
    }
    return hash;
  }

  static int _hashMap<K, V>(Map<K, V> map) {
    var hash = 0;
    for (final entry in map.entries) {
      hash = 31 * hash + entry.key.hashCode;
      hash = 31 * hash + (entry.value?.hashCode ?? 0);
    }
    return hash;
  }
}
