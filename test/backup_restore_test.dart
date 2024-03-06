import 'dart:io';

import 'package:flavors_yaml_merger/tools/file_manager.dart';
import 'package:test/test.dart';

import 'test_constants/test_constants.dart';

void main() {
  FileManager fileManager = FileManager();

  group('Pubspec Editing Tests', () {
    test('Backup pubspec.yaml', () {
      fileManager.backupPubspec(
        filePath: TestConstants.mainYamlMock.path,
        targetPath: TestConstants.backupPath,
      );
      expect(File(TestConstants.backupPath).existsSync(), true);
      fileManager.deletePubspec(targetPath: TestConstants.backupPath);
    });

    test('Restore pubspec.yaml', () {
      fileManager.backupPubspec(
        filePath: TestConstants.mainYamlMock.path,
        targetPath: TestConstants.backupPath,
      );
      fileManager.restorePubspec(
        sourcePath: TestConstants.backupPath,
        targetPath: TestConstants.mainYamlMock.path,
      );
      expect(File(TestConstants.backupPath).existsSync(), false);
    });
  });
}
