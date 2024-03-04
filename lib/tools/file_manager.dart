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

  void writePubspecFile(String fileName, Map<dynamic, dynamic> content) {
    try {
      var yamlWriter = YamlWriter();
      var yamlDoc = yamlWriter.write(content);
      File('pubspec.yaml').writeAsStringSync(yamlDoc);
    } catch (exception) {
      stderr.writeln("Couldn't read $fileName");
      stderr.writeln(exception);
      exit(2);
    }
  }

  /// Backup the pubspec.yaml
  void backupPubspec() {
    try {
      File('pubspec.yaml').copySync('pubspec_backup.yaml');
    } catch (exception) {
      stderr.writeln("Couldn't backup main pubspec.yaml");
      stderr.writeln(exception);
    }
  }

  /// Restore pubspec.yaml from backup file
  void restorePubspec() {
    try {
      File('pubspec_backup.yaml').renameSync('pubspec.yaml');
    } catch (exception) {
      stderr.writeln("Couldn't restore main pubspec.yaml");
      stderr.writeln(exception);
    }
  }
}
