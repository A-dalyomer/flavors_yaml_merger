import 'dart:io';

import 'package:flavors_yaml_merger/service/match_flavor_with_main.dart';
import 'package:flavors_yaml_merger/tools/file_manager.dart';
import 'package:flavors_yaml_merger/flavors_yaml_merger.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  final String mocksPath = 'test/yaml_mocks/';
  final backupPath = '$mocksPath/pubspec_backup.yaml';
  final File mainYamlMock = File('$mocksPath/main_mock.yaml');
  final File flavorYamlMock = File('$mocksPath/flavor_mock.yaml');
  FileManager fileManager = FileManager();

  group('Pubspec Editing Tests', () {
    test('Backup pubspec.yaml', () {
      fileManager.backupPubspec(
        filePath: mainYamlMock.path,
        targetPath: backupPath,
      );
      expect(File(backupPath).existsSync(), true);
    });

    test('Restore pubspec.yaml', () {
      fileManager.restorePubspec(
        sourcePath: backupPath,
        targetPath: mainYamlMock.path,
      );
      expect(File(backupPath).existsSync(), false);
    });

    test('Update pubspec.yaml values from flavor', () {
      fileManager.backupPubspec(
        filePath: mainYamlMock.path,
        targetPath: backupPath,
      );
      FlavorsMerger flavorsMerger = FlavorsMerger(
        mainPubspecYaml: mainYamlMock,
        flavorYamFile: flavorYamlMock,
      );
      flavorsMerger.mergePubspec();
      var updatedPubspec = loadYaml(mainYamlMock.readAsStringSync());
      expect(updatedPubspec['dependencies'], isNot(equals(null)));
      print(updatedPubspec['dependencies']);
      print(updatedPubspec);
      expect(updatedPubspec['dependencies']['args'], '^2.4.2');
      fileManager.deletePubspec(targetPath: backupPath);
    });

    test('flavor yaml matcher', () {
      FlavorsMerger merger = FlavorsMerger(
        mainPubspecYaml: mainYamlMock,
        flavorYamFile: flavorYamlMock,
      );
      merger.mergePubspec();
    });

    test('matcher test', () {
      flavorMatcher() => matchFlavorFile(
            flavorName: "mock",
            flavorYamlPath: flavorYamlMock.path,
            mainYamlPath: mainYamlMock.path,
          );
      expect(flavorMatcher, isNot(throwsException));
    });
  });
}
