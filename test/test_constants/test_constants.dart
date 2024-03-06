import 'dart:io';

class TestConstants {
  static final String mocksPath = 'test/yaml_mocks';
  static final backupPath = '$mocksPath/pubspec_backup.yaml';
  static final File mainYamlMock = File('$mocksPath/main_mock.yaml');
  static final File flavorYamlMock = File('$mocksPath/flavor_mock.yaml');
}
