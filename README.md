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
Clean artchiture

### Main project structure

![main project structure!](/app_docs_assets/main%20project%20architecture.png)

Project structure

The above image depicts the project structure. The common folder contains reusable files. The data layer is responsible for the remote and local database connectivities. The DI folder handles all dependency injections. The domain layer contains view entities and repositories for handling all requests. The presentation layer includes the user journeys and business logic/state-managers (blocs).

## Project Set-Up instructions

After cloning the repo, run this command to install all dependencies.

``` dart
flutter pub get
 ```

Then run the following command to create all generated code.

``` dart
flutter pub run build_runner build --delete-conflicting-outputs
```

After running the above commands, you should be able to run the app successfully on your emulators or physical devices. If issues arise from any dependencies, please visit the dependencies configuration guidelines. The list of all dependencies can be found in the pubspec.YAML file. All dependencies used in this project can be found on the [pub.dev.](https://pub.dev/) You can search for a given dependency/package using the search bar. The below images explain how to get more information about a given dependency.

![pub.dev!](/app_docs_assets/pub%20site%20image.png 'pub.dev website')
Searching for the mobile scanner package.

![Search result](/app_docs_assets/pub%20result.png 'Search result')

Search result

![Package](/app_docs_assets/pub%20package.png)

package

## Dependencies and configurations

The app contains both dev dependencies and app dependencies. Dev-dependencies are needed to generate dev, asset, and configuration files. While the app dependencies are needed to run the app.

### Stripe dependency configuration

Here is a guide to the stripe dependency configuration. Pay attention to the below code snippet.

``` dart
WidgetsFlutterBinding.ensureInitialized();
Stripe.publishableKey = "add your stripe publishable key here";
Stripe.merchantIdentifier = 'example.idonation.stripe.test';
Stripe.urlScheme = 'flutterstripe';
```

The above depicts some needed declarations that should be added to the app’s main method. for more clarity read the [flutter stripe package documentation.](https://pub.dev/packages/flutter_stripe) To get the stripe publishable key, go to <https://dashboard.stripe.com/test/apikeys> and copy the publishable key.

![stripe publishable key](/app_docs_assets/stritpublishable%20key.png 'getting your stripe publishable key')
stripe publishable key

## Manual user test guide

Below is a table depicting the Manual and end-to-test guide.

| Test case | Description | Expected Result |
| --------- | ----------- | --------------- |
| Login     | <ul><li>The email field is required. Password is required.</li><li>The reset password should link to the reset password field.</li><li>Remember-me field should be selectable</li><li>The sign-in button should only be enabled when the above requirements pass.</li><li>When the user inputs an invalid password or email, App should trough an invalid error message should be expected.</li><li>When the user opts in for remember-me, the User email should be prefield on the next login.</li></ul> | <ul><li>After a successful login, The user should navigate to the Home page.</li><li>If the email is verified and the user has completed the onboading.</li><li>If the user's email is not verified, The user should navigate to Verify email page.</li><li>If the user has not boarded, He should navigate the onboarding page.</li></ul> |
