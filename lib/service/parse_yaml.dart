import 'package:yaml/yaml.dart';

import 'parse_yaml_list_value.dart';
import 'parse_yaml_value.dart';

/// parse map values to yaml lines
String parseYamlContent(Map<dynamic, dynamic> yamlString, {int level = 0}) {
  String last = '';
  yamlString.forEach((key, value) {
    if (value is YamlList) {
      last += parseYamlListValue(parentKey: key, yamlList: value, level: 1);
    } else {
      last += parseYamlValue(key, value, level: level);
    }
  });
  return last;
}
