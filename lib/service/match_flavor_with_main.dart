import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

import '../tools/match_string_blocks.dart';

void matchFlavorFile({
  required String flavorYamlPath,
  required String flavorName,
}) {
  stdout.writeln("Matching $flavorName yaml");
  try {
    /// Load workspace yaml file as lines
    List<String> mainPubspecLines = File('pubspec.yaml').readAsLinesSync();

    /// Load flavor yaml file
    Map<dynamic, dynamic> flavorPubspec = Map.of(
      loadYaml(File(flavorYamlPath).readAsStringSync()),
    );

    /// Store in match state to avoid the lines skipper
    bool isInMatching = false;

    /// Loop on all main pub file lines
    for (int i = 0; i < mainPubspecLines.length; i++) {
      /// Skip empty lines
      if (mainPubspecLines[i].trim().isEmpty) {
        continue;
      }

      /// Stop the in matcher state and skip line on flavor block end
      if (mainPubspecLines[i]
          .trimLeft()
          .startsWith("# end flavor $flavorName")) {
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

        /// Skip flavor header comment line
        if (i + 1 < mainPubspecLines.length) {
          i++;
        }
      }

      /// Reached matching flavor block
      isInMatching = true;

      /// Gather block content to match it with flavor block
      String mainYamlSectionBlock = '';
      while (isInMatching) {
        mainYamlSectionBlock += '${mainPubspecLines[i]}\n';
        i++;

        /// Stop block aggregation
        if (mainPubspecLines[i]
            .trimLeft()
            .startsWith("# end flavor $flavorName")) {
          isInMatching = false;
          i++;
        }
      }

      /// Block match state in flavor file
      bool blockFound = false;

      /// Loop all flavor file entries to match the current block
      for (int j = 0; j < flavorPubspec.length; j++) {
        final YamlWriter yamlWriter = YamlWriter();
        final value = flavorPubspec.entries.elementAt(j).value;
        final String yamlDoc = yamlWriter.write(value).replaceAll('\'', '');
        blockFound = matchStringBlocks(mainYamlSectionBlock, yamlDoc);
        if (blockFound) {
          break;
        }
      }

      /// Block not found and stop executing
      if (!blockFound) {
        stderr.writeln("Missing content while matching block");
        stderr.writeln(mainYamlSectionBlock);
        exit(2);
      }
    }
  } catch (exception) {
    stderr.writeln(exception);
    exit(2);
  }
}
