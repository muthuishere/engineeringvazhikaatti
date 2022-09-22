extension IterableExtension<T> on Iterable<T> {
  bool containsInList(List<T>? comparableElements) {
    if (null == comparableElements || comparableElements.length <= 0)
      return false;

    for (T element in this) {
      for (T elementToBeCompared in comparableElements) {
        if (element == elementToBeCompared) return true;
      }
    }
    return false;
  }


}

extension IterableToMap<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> toMap() => Map<K, V>.fromEntries(this);
}
