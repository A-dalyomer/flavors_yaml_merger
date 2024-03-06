import 'dart:io';

import 'package:flavors_yaml_merger/tools/file_manager.dart';
import 'tools/update_value_in_map.dart';
import 'package:yaml/yaml.dart';

/// Holds the merger logic for merging flavor blocks in the main pubspec.yaml
///
/// The [mainPubspecYaml] is actually the project pubspec.yaml.
/// The [flavorYamFile] represents the flavor yaml file to be merged in main.
class FlavorsMerger {
  FlavorsMerger({
    required this.mainPubspecYaml,
    required this.flavorYamFile,
  });
  final File mainPubspecYaml;
  final File flavorYamFile;

  /// Create an instance of file manager
  final FileManager _fileManager = FileManager();

  /// start the merging progress with the provided flavor yaml file path
  void mergePubspec() {
    /// Load the both working yaml files
    Map<dynamic, dynamic> mainPubspec = Map.of(
      loadYaml(mainPubspecYaml.readAsStringSync()),
    );
    Map<dynamic, dynamic> flavorPubspec = Map.of(
      loadYaml(flavorYamFile.readAsStringSync()),
    );

    /// Assign the flavor yaml values to the main yaml values
    flavorPubspec.forEach((section, values) {
      mainPubspec = updateValueInNestedMap(
        key: section,
        newValue: values,
        map: mainPubspec,
      );
    });

    /// Done merging and write the new file to replace the old one
    _fileManager.writePubspecFile(mainPubspecYaml.path, mainPubspec);
  }
}
