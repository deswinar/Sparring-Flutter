class Helpers {
  Map<K, V> convertToMap<K, V>(dynamic map) {
    if (map is Map) {
      return map.map((key, value) {
        final newKey = key as K;
        final newValue = value is Map ? convertToMap<K, V>(value) : value;
        return MapEntry(newKey, newValue);
      });
    }
    return map as Map<K, V>;
  }
}
