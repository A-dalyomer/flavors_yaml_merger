/// searches for specific key in a nested map and append a new value to it
Map<dynamic, dynamic> updateValueInNestedMap({
  required dynamic key,
  required Map<dynamic, dynamic> map,
  dynamic newValue,
}) {
  for (var entry in map.entries) {
    var currentKey = entry.key;
    var currentValue = entry.value;

    if (currentKey == key) {
      return {...map, currentKey: newValue}; // Found the key, update its value
    } else if (currentValue is Map<dynamic, dynamic>) {
      // recursion callback
      var updatedValue = updateValueInNestedMap(
        key: key,
        newValue: newValue,
        map: currentValue,
      );
      if (updatedValue != currentValue) {
        return {...map, currentKey: updatedValue};
      }
    }
  }
  return map;
}
