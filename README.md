# Overview
A dart command line tool to merge current build flavor yaml contents to the main `pubspec.yaml`,
Mainly to help removing the other app flavor assets and dependencies from the current app build, 
Making it easier for you to focus on build features instead of caring about including all flavors 
assets in your next app build and dynamically increasing the final app size
You can also utilize the matcher feature to match the build flavor file content with its corresponding 
sections in main `pubspec.yaml` and make sure no dependencies are missing from your build.

Using this approach will reduce developers overhead of having to remove other app flavors
dependencies from the project and even can be utilized in your CI/CD pipeline.
 
## Installation

Add it to dev dependencies:

```console
dart pub add --dev flavors_yaml_merger
```

Or with flutter using:

```console
flutter pub add --dev flavors_yaml_merger
```

###### Activate the tool in dart
You need to activate it in dart to use it:

```console
dart pub global activate flavors_yaml_merger
```

## Usage
For basic usage you only need to:
1. Create a separate pubspec file for each app flavor 
2. Name scheme must be as follows `pubspec_flavor.yaml` where the `flavor` is your build flavor name.
3. Include a copy of the specific dependencies for flavor in the related pubspec file.
4. All flavor pubspec dependencies should be in the root section as shown in Examples.

Run this command to merge flavor file
```console  
dart run flavors_yaml_merger -f <flavor>

# or use the similar command
dart run flavors_yaml_merger --flavor_name <flavor>
```

Run this command to restore your main `pubspec.yaml`
```console  
dart run flavors_yaml_merger:restore_backup_yaml
```

Use the -m flag to enable yaml matcher:
```console  
dart run flavors_yaml_merger -f <flavor> -m

# or use the similar command
dart run flavors_yaml_merger --matcher true
```

Use the -b flag to disable the backup of `pubspec.yaml`
```console  
dart run flavors_yaml_merger -f <flavor> -b false

# This is similar to the following:
dart run flavors_yaml_merger -f <flavor> --enable_backup false
```

You can also use your own flavor yaml path and naming scheme by using the following command
```console  
dart run flavors_yaml_merger -f <flavor> -p "path_to_flavor_yaml"

# This is similar to the following:
dart run flavors_yaml_merger -f <flavor> --flavor_path "path_to_flavor_yaml"
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

## Contributors
- Ahmad Daly omer
