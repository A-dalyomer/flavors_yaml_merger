import 'dart:io';

import 'package:flavors_yaml_merger/tools/file_manager.dart';

/// Restore the previous pubspec.yaml backup.
void main(List<String> args) {
  /// Successful exit code at start
  exitCode = 0;

  FileManager fileManager = FileManager();

  /// Restore main pubspec.yaml
  fileManager.restorePubspec();
}
