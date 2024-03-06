import 'package:args/args.dart';

/// DTO for holding launch command parameters.
///
/// The [matcherState] sets matcher configurations
/// when set to true the merger will match yaml content before merging.
/// when not specified it defaults is false.
///
/// The [flavorName] must match your app flavor name for retrieving the
/// related yaml for the passed flavor.
/// however, you can pass the optional [flavorYamlPath] parameter
/// to override the [flavorName] and pass custom flavor yaml name and path.
///
/// The [backupRequired] sets backup configuration
/// when set to false it will disable backup of main yaml file,
/// when not specified it defaults is true.
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
