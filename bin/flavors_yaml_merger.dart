import 'dart:developer';
import 'dart:io';

import 'package:flavors_yaml_merger/model/arguments_model.dart';
import 'package:flavors_yaml_merger/service/match_flavor_with_main.dart';
import 'package:flavors_yaml_merger/tools/file_manager.dart';
import 'package:flavors_yaml_merger/flavors_yaml_merger.dart'
    as flavors_yaml_merger;

/// Start the merger process with the provided [args] configurations.
void main(List<String> args) {
  /// Successful exit code at start
  exitCode = 0;

  /// parse passed arguments
  ArgumentsModel arguments = ArgumentsModel.parse(args);
  late final String flavorYamlPath;

  /// Assign flavor yaml file path
  if (arguments.flavorYamlPath != null) {
    flavorYamlPath = arguments.flavorYamlPath!;
  } else {
    flavorYamlPath = 'pubspec_${arguments.flavorName}.yaml';
  }

  if (arguments.matcherState) {
    matchFlavorFile(
      flavorName: arguments.flavorName,
      flavorYamlPath: flavorYamlPath,
      mainYamlPath: 'pubspec.yaml',
    );
  }

  /// Backup the main yaml for restore later
  if (arguments.backupRequired) {
    FileManager fileManager = FileManager();
    fileManager.backupPubspec();
  }

  /// Merge the flavor yaml
  log("merging ${flavorYamlPath.split('/').last}");
  flavors_yaml_merger.FlavorsMerger flavorsMerger =
      flavors_yaml_merger.FlavorsMerger(
    mainPubspecYaml: File('pubspec.yaml'),
    flavorYamFile: File(flavorYamlPath),
  );
  flavorsMerger.mergePubspec();
}
