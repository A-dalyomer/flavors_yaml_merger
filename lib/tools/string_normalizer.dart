/// Normalize strings to remove extra whitespaces and newlines
String normalizeString(String input) {
  return input.replaceAll(RegExp(r'\s+'), ' ').trim();
}
