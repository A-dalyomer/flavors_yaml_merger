/// Searches for specific key in a nested map and append a new value to it
bool matchValueInNestedMap({
  required dynamic key,
  required Map<dynamic, dynamic> map,
  dynamic matchedValue,
}) {
  for (var entry in map.entries) {
    var currentKey = entry.key;
    var currentValue = entry.value;

    if (currentKey == key) {
      return currentValue == matchedValue;
    } else if (currentValue is Map<dynamic, dynamic>) {
      /// recursion callback
      var updatedValue = matchValueInNestedMap(
        key: key,
        matchedValue: matchedValue,
        map: currentValue,
      );
      return updatedValue;
    }
  }
  return false;
}
