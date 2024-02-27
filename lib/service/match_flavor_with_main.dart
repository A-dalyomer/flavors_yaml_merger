import 'dart:io';

import 'package:yaml/yaml.dart';

void matchFlavorFile(
    {required String flavorYamlPath, required String flavorName}) {
  /// Load the both working yaml files
  List<String> mainPubspecLines = File('pubspec.yaml').readAsLinesSync();
  List<String> flavorPubspecLines = File(flavorYamlPath).readAsLinesSync();

  /// Load the both working yaml files
  Map<dynamic, dynamic> flavorPubspec = Map.of(
    loadYaml(File(flavorYamlPath).readAsStringSync()),
  );

  for (int i = 0; i < mainPubspecLines.length; i++) {
    if (mainPubspecLines[i]
        .trimLeft()
        .startsWith("# flavor ${RegExp(r"(?!" + flavorName + r")\b\w+\b")}")) {
      continue;
    }

    /// Skip non flavor lines
    while (!mainPubspecLines[i].trimLeft().startsWith("# flavor $flavorName")) {
      if (i + 1 < mainPubspecLines.length) {
        i++;
      } else {
        stdout.writeln("Matched flavor file content");
        return;
      }
    }
    if (i + 1 < mainPubspecLines.length) {
      i++;
    }

    bool lineIFound = false;
    for (int j = 0; j < flavorPubspecLines.length; j++) {
      bool inNextSection = false;
      flavorPubspec.forEach((section, value) {
        if (section == flavorPubspecLines[j].trimLeft().replaceAll('-', '')) {
          inNextSection = true;
        }
      });

      if (inNextSection) break;
      if (flavorPubspecLines[j].trimLeft() == mainPubspecLines[i].trimLeft()) {
        lineIFound = true;
        break;
      }
    }
    if (!lineIFound) {
      stderr.writeln("Missing line in flavor file");
      stderr.writeln(mainPubspecLines[i]);
      exit(2);
    }
  }
}
