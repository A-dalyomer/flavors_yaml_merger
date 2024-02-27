import 'dart:io';
import 'package:flavors_yaml_merger/tools/file_manager.dart';
import 'package:flavors_yaml_merger/flavors_yaml_merger.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('Pubspec Editing Tests', () {
    // Test backupPubspec function
    test('Backup pubspec.yaml', () {
      FileManager fileManager = FileManager();
      fileManager.backupPubspec();
      expect(File('pubspec_backup.yaml').existsSync(), true);
    });

    // Test restorePubspec function
    test('Restore pubspec.yaml', () {
      FileManager fileManager = FileManager();
      fileManager.restorePubspec();
      expect(File('pubspec_backup.yaml').existsSync(), false);
    });

    test('Update pubspec.yaml with flavor', () {
      var flavorYamlContent = '''
        dependencies:
          flutter:
            sdk: flutter
          cupertino_icons: ^1.0.2
      ''';
      File('flavor_mock.yaml').writeAsStringSync(flavorYamlContent);

      // Update pubspec.yaml with the mock flavor
      FlavorsMerger flavorsMerger = FlavorsMerger();
      flavorsMerger.mergePubspec('flavor_mock.yaml');

      // Verify that the values from the flavor are added to pubspec.yaml
      var updatedPubspec = loadYaml(File('pubspec.yaml').readAsStringSync());
      expect(updatedPubspec['dependencies']['cupertino_icons'], '^1.0.0');

      // Clean up the mock flavor YAML file
      File('flavor_mock.yaml').deleteSync();
    });
  });
}
