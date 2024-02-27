import 'package:yaml/yaml.dart';

import 'parse_yaml.dart';
import 'parse_yaml_list_value.dart';

String parseYamlValue(
  dynamic key,
  dynamic value, {
  int level = 0,
  bool isFromList = false,
}) {
  String last = '';
  if (value is Map) {
    String inner = parseYamlContent(value, level: 1);
    last += ("${"  " * level}$key:\n${"  " * level}$inner\n");
  } else if (value is YamlList) {
    last += parseYamlListValue(
      parentKey: key,
      yamlList: value,
      level: level + 1,
      isFromNormal: true,
    );
  } else {
    if (key == "sdk") {
      last += ("${"  " * level}$key: \"$value\"\n");
    } else {
      last += ("${isFromList ? '' : ("  " * level)}$key: $value\n");
    }
  }
  return last;
}
