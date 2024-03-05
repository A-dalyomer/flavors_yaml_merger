import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

class FileManager {
  /// Read a pubspec file
  Map<dynamic, dynamic> readPubspecFile(String fileName) {
    try {
      return Map.of(loadYaml(File(fileName).readAsStringSync()));
    } catch (exception) {
      stderr.writeln("Couldn't read $fileName");
      stderr.writeln(exception);
      exit(2);
    }
  }

  void writePubspecFile(String filePath, Map<dynamic, dynamic> content) {
    try {
      var yamlWriter = YamlWriter();
      var yamlDoc = yamlWriter.write(content);
      File(filePath).writeAsStringSync(yamlDoc);
    } catch (exception) {
      stderr.writeln("Couldn't write file at $filePath");
      stderr.writeln(exception);
      exit(2);
    }
  }

  /// Backup the pubspec.yaml
  void backupPubspec({String? filePath, String? targetPath}) {
    try {
      File(filePath ?? 'pubspec.yaml').copySync(
        targetPath ?? 'pubspec_backup.yaml',
      );
    } catch (exception) {
      stderr.writeln("Couldn't backup main pubspec.yaml");
      stderr.writeln(exception);
    }
  }

  /// Restore pubspec.yaml from backup file
  void restorePubspec({String? sourcePath, String? targetPath}) {
    try {
      File(sourcePath ?? 'pubspec_backup.yaml')
          .renameSync(targetPath ?? 'pubspec.yaml');
    } catch (exception) {
      stderr.writeln("Couldn't restore main pubspec.yaml");
      stderr.writeln(exception);
    }
  }

  /// Delete specified file
  void deletePubspec({required String targetPath}) {
    try {
      File(targetPath).deleteSync();
    } catch (exception) {
      stderr.writeln("Couldn't restore main pubspec.yaml");
      stderr.writeln(exception);
    }
  }
}
