import 'dart:io';

import 'package:yaml/yaml.dart';

void matchFlavorFile({
  required String flavorYamlPath,
  required String flavorName,
}) {
  stdout.writeln("Matching $flavorName yaml");
  try {
    /// Load the both working yaml files
    List<String> mainPubspecLines = File('pubspec.yaml').readAsLinesSync();
    List<String> flavorPubspecLines = File(flavorYamlPath).readAsLinesSync();

    /// Load the both working yaml files
    Map<dynamic, dynamic> flavorPubspec = Map.of(
      loadYaml(File(flavorYamlPath).readAsStringSync()),
    );

    /// Store in match state to avoid the lines skipper
    bool isInMatching = false;

    for (int i = 0; i < mainPubspecLines.length; i++) {
      if (mainPubspecLines[i].trim().isEmpty) {
        continue;
      }

      /// Stop the in matcher state and skip line on non targeted flavors header
      if (mainPubspecLines[i]
          .trimLeft()
          .startsWith(RegExp(r"^# flavor(?!.*\b" + flavorName + r"\b).*"))) {
        isInMatching = false;
        continue;
      }

      /// Skip non flavor lines and end script if file is ended
      if (!isInMatching) {
        while (!mainPubspecLines[i]
            .trimLeft()
            .startsWith("# flavor $flavorName")) {
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
      }

      isInMatching = true;

      /// Line match state in flavor file
      bool lineIFound = false;
      for (int j = 0; j < flavorPubspecLines.length; j++) {
        bool inNextSection = false;
        flavorPubspec.forEach((section, value) {
          if (section == flavorPubspecLines[j].trimLeft().replaceAll('-', '')) {
            inNextSection = true;
          }
        });

        if (inNextSection) break;
        if (flavorPubspecLines[j].trimLeft() ==
            mainPubspecLines[i].trimLeft()) {
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
  } catch (exception) {
    stderr.writeln(exception);
    exit(2);
  }
}
