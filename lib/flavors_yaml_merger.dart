import 'dart:io';

import 'package:flavors_yaml_merger/tools/file_manager.dart';
import 'tools/update_value_in_map.dart';
import 'package:yaml/yaml.dart';

class FlavorsMerger {
  /// Create an instance of file manager
  final FileManager _fileManager = FileManager();

  /// start the merging progress with the provided flavor yaml file path
  void mergePubspec(String flavorYamlPath) {
    /// Load the both working yaml files
    Map<dynamic, dynamic> mainPubspec = Map.of(
      loadYaml(File('pubspec.yaml').readAsStringSync()),
    );
    Map<dynamic, dynamic> flavorPubspec = Map.of(
      loadYaml(File(flavorYamlPath).readAsStringSync()),
    );

    /// Backup the main yaml for restore later
    _fileManager.backupPubspec();

    /// Assign the flavor yaml values to the main yaml values
    flavorPubspec.forEach((section, values) {
      mainPubspec = updateValueInNestedMap(
        key: section,
        newValue: values,
        map: mainPubspec,
      );
    });

    _fileManager.writePubspecFile("pubspec.yaml", mainPubspec);
  }
}
