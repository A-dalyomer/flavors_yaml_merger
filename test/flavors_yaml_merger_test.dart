import 'package:flavors_yaml_merger/service/match_flavor_with_main.dart';
import 'package:flavors_yaml_merger/tools/file_manager.dart';
import 'package:flavors_yaml_merger/flavors_yaml_merger.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'test_constants/test_constants.dart';

void main() {
  FileManager fileManager = FileManager();

  group('Merger and matcher Tests', () {
    test('Update pubspec.yaml values from flavor', () {
      fileManager.backupPubspec(
        filePath: TestConstants.mainYamlMock.path,
        targetPath: TestConstants.backupPath,
      );
      FlavorsMerger flavorsMerger = FlavorsMerger(
        mainPubspecYaml: TestConstants.mainYamlMock,
        flavorYamFile: TestConstants.flavorYamlMock,
      );
      flavorsMerger.mergePubspec();
      var updatedPubspec =
          loadYaml(TestConstants.mainYamlMock.readAsStringSync());
      expect(updatedPubspec['dependencies'], isNot(equals(null)));
      expect(updatedPubspec['dependencies']['args'], '^2.4.2');
      fileManager.restorePubspec(
        sourcePath: TestConstants.backupPath,
        targetPath: TestConstants.mainYamlMock.path,
      );
    });

    test('matcher test', () {
      flavorMatcher() => matchFlavorFile(
            flavorName: "mock",
            flavorYamlPath: TestConstants.flavorYamlMock.path,
            mainYamlPath: TestConstants.mainYamlMock.path,
          );
      expect(flavorMatcher, isNot(throwsException));
    });
  });
}
