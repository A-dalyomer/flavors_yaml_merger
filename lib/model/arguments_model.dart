import 'package:args/args.dart';

class ArgumentsModel {
  ArgumentsModel({
    required this.matherState,
    required this.flavorName,
    this.flavorYamlPath,
  });
  late final String flavorName;
  late final String? flavorYamlPath;
  late final bool matherState;

  factory ArgumentsModel.parse(List<String> arguments) {
    final parser = ArgParser()
      ..addFlag("matcher", abbr: "m", defaultsTo: true)
      ..addOption("flavor_name", abbr: "f", mandatory: true)
      ..addOption("flavor_path", abbr: "p");

    ArgResults argResults = parser.parse(arguments);
    print(argResults['flavor_name']);
    return ArgumentsModel(
      matherState: argResults['matcher'],
      flavorName: argResults['flavor_name'],
      flavorYamlPath: argResults['flavor_path'],
    );
  }
}
