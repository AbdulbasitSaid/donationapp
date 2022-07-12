# Idonatio Mobile app Technical documentation

Complete technical documentation for the Idonatio project. This documentation includes the following:

1. Tools used. For example, the Flutter framework.

2. Mobile app architecture.

3. Project set-up instructions.

4. Dependencies and configurations.

5. Manual user test guide.

## Tools used. For example, the Flutter framework

Flutter is the selected tool used for app development. To install flutter, please visit [flutter. dev.](https://docs.flutter.dev/get-started/install) Flutter development environment can work on  the following operating systems:

- Windows.

- MacOs.

- Linux.

- ChromOS.

For a detailed installation guide, please visit the [installation guide.](https://docs.flutter.dev/get-started/install) Select your operating system and proceed with the setup.

## Mobile app architecture

The mobile app design architecture is derived, from Uncle, bobs clean Architecture pattern, the Flutter-bloc architecture pattern, and some personal design decisions. We chose the clean-architecture pattern to improve the separation of concern.

Below is the image that depicts the clean architecture.

![clean archicture diagram!](/app_docs_assets/clean_architecture_diagram.png 'clean artchiture')
<p style='text-align:center'>Clean artchiture</p>

### Main project structure

![main project structure!](/app_docs_assets/main%20project%20architecture.png)
<p style='text-align:center'>Project structure</p>

The above image depicts the project structure. The common folder contains reusable files. The data layer is responsible for the remote and local database connectivities. The DI folder handles all dependency injections. The domain layer contains view entities and repositories for handling all requests. The presentation layer includes the user journeys and business logic/state-managers (blocs).

## Project Set-Up instructions

After cloning the repo, run this command to install all dependencies.

```
flutter pub get
 ```

Then run the following command to create all generated code.

```
flutter pub run build_runner build --delete-conflicting-outputs
```

After running the above commands, you should be able to run the app successfully on your emulators or physical devices. If issues arise from any dependencies, please visit the dependencies configuration guidelines. The list of all dependencies can be found in the pubspec.YAML file. All dependencies used in this project can be found on the [pub.dev.](https://pub.dev/) You can search for a given dependency/package using the search bar. The below images explain how to get more information about a given dependency.

![pub.dev!](/app_docs_assets/pub%20site%20image.png 'pub.dev website')
<center>Searching for the mobile scanner package.</center>
