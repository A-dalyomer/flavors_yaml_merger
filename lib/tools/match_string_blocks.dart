import 'string_normalizer.dart';

/// Matches the provided strings
/// By removing whitespaces and new lines
bool matchStringBlocks(String predefinedString, String input) {
  String normalPredefinedString = normalizeString(predefinedString);
  String normalInput = normalizeString(input);

  return normalPredefinedString == normalInput;
}
