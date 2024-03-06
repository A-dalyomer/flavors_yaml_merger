## Example: commands

Run this command to merge flavor file
```console
dart run flavors_yaml_manager --flavor_name <flavor>
```

Use the -m flag to enable yaml matcher:
```console
dart run flavors_yaml_manager --matcher true
```

Use the -b flag to disable the backup of `pubspec.yaml`
```console  
dart run flavors_yaml_manager -f <flavor> --enable_backup false
```

You can also use your own flavor yaml path and naming scheme by using the following command
```console
dart run flavors_yaml_manager -f <flavor> --flavor_path "path_to_flavor_yaml"
```

### Example: pubspec_dev.yaml
Here's an example of a pubspec_<flavor_name> filer:
```yaml
dependencies:
  cupertino_icons: ^1.0.2
  dio: ^5.2.1+1
  shared_preferences: ^2.2.2

fonts:
  - family: ibm plex
    fonts:
      - asset: assets/flavor1/fonts/body_label/IBMPlexSansArabic-Regular.ttf
        weight: 300
      - asset: assets/flavor1/fonts/body_label/IBMPlexSansArabic-Regular.ttf
        weight: 400
      - asset: assets/flavor1/fonts/body_label/IBMPlexSansArabic-Medium.ttf
        weight: 500
      - asset: assets/flavor1/fonts/body_label/IBMPlexSansArabic-SemiBold.ttf
        weight: 600
      - asset: assets/flavor1/fonts/body_label/IBMPlexSansArabic-SemiBold.ttf
        weight: 700

assets:
  - assets/flavor1/png/
  - assets/flavor1/png/onboarding/
  - assets/flavor1/animation/
```

## pubspec.yaml
The `pubspec.yaml` must include all the sections present in flavor file in case the matcher is enabled.
If matcher is enabled you have to add the corresponding comments to define flavor sections for matcher.
```yaml
dependencies:
  # flavor flavor1_name                  <- Add this line on flavor1 dependencies
  cupertino_icons: ^1.0.2
  dio: ^5.2.1+1
  shared_preferences: ^2.2.2
  # end flavor flavor1_name              <- Add this line on flavor1 dependencies

  # flavor flavor2_name                  <- Add this line on flavor2 dependencies
  connectivity_plus: ^5.0.1
  # end flavor flavor2_name              <- Add this line on flavor2 dependencies


fonts:
  # flavor flavor1_name                  <- Add this line on flavor1 fonts
  - family: ibm plex
    fonts:
      - asset: assets/flavor1/fonts/body_label/IBMPlexSansArabic-Regular.ttf
        weight: 300
      - asset: assets/flavor1/fonts/body_label/IBMPlexSansArabic-Regular.ttf
        weight: 400
      - asset: assets/flavor1/fonts/body_label/IBMPlexSansArabic-Medium.ttf
        weight: 500
      - asset: assets/flavor1/fonts/body_label/IBMPlexSansArabic-SemiBold.ttf
        weight: 600
      - asset: assets/flavor1/fonts/body_label/IBMPlexSansArabic-SemiBold.ttf
        weight: 700
  # end flavor flavor1_name              <- Add this line on flavor1 fonts

assets:
  # flavor flavor1_name                  <- Add this line on flavor1 assets
  - assets/flavor1/png/
  - assets/flavor1/png/onboarding/
  - assets/flavor1/animation/
  # end flavor flavor1_name              <- Add this line on flavor1 assets

  - assets/flavor1/locales/
```


You need to run this command to restore your main `pubspec.yaml` if you didn't disable backup.
```console  
dart run flavors_yaml_merger:restore_backup_yaml
```