import 'package:args/args.dart';

class ArgumentsModel {
  ArgumentsModel({
    required this.matcherState,
    required this.flavorName,
    required this.backupRequired,
    this.flavorYamlPath,
  });
  late final String flavorName;
  late final String? flavorYamlPath;
  late final bool matcherState;
  late final bool backupRequired;

  factory ArgumentsModel.parse(List<String> arguments) {
    final parser = ArgParser()
      ..addFlag("matcher", abbr: "m", defaultsTo: false)
      ..addFlag("enable_backup", abbr: "b", defaultsTo: true)
      ..addOption("flavor_name", abbr: "f", mandatory: true)
      ..addOption("flavor_path", abbr: "p");

    ArgResults argResults = parser.parse(arguments);
    print(argResults['flavor_name']);
    return ArgumentsModel(
      matcherState: argResults['matcher'],
      flavorName: argResults['flavor_name'],
      backupRequired: argResults['enable_backup'],
      flavorYamlPath: argResults['flavor_path'],
    );
  }
}
