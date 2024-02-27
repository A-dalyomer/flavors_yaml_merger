import 'package:yaml/yaml.dart';

import 'parse_yaml_value.dart';

String parseYamlListValue({
  required String parentKey,
  required YamlList yamlList,
  int level = 0,
  bool isFromNormal = false,
}) {
  String last = '';
  for (var element in yamlList) {
    if (element is Map) {
      element.forEach((key, value) {
        last += '${"  " * level}- ${parseYamlValue(
          key,
          value,
          level: level,
          isFromList: true,
        )}';
      });
    } else if (element is String) {
      last += ("${"  " * (level + 1)}- $element\n");
    }
  }
  last = '$parentKey: \n$last';
  return '${isFromNormal ? '' : ("  " * level)}$last';
}
