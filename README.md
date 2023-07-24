# Flutter App Dependencies

This is a Flutter app that utilizes several external packages to enhance its functionality and user experience. Below is a list of the packages used in this project:

## Package List

1. **firebase_core: ^2.15.0**
   - [Firebase Core](https://pub.dev/packages/firebase_core) is a Flutter plugin that enables Firebase services in your app. It provides the necessary setup and configuration for using Firebase services.

2. **http: ^1.0.0**
   - [HTTP](https://pub.dev/packages/http) is a Dart package that provides the ability to make HTTP requests. It is used in this app to communicate with APIs and fetch data from remote servers.

3. **provider: ^6.0.5**
   - [Provider](https://pub.dev/packages/provider) is a state management solution for Flutter that makes it easy to manage and share state between widgets. It follows the InheritedWidget pattern and allows for efficient state updates.

4. **intl: ^0.18.1**
   - [Intl](https://pub.dev/packages/intl) is a Flutter package that provides internationalization and localization utilities. It helps in formatting dates, numbers, and messages based on the user's locale.

5. **carousel_slider: ^4.2.1**
   - [Carousel Slider](https://pub.dev/packages/carousel_slider) is a Flutter package that provides a carousel-like widget to display a list of items in a sliding manner. It is commonly used for creating image carousels and image sliders.

6. **cached_network_image: ^3.2.3**
   - [Cached Network Image](https://pub.dev/packages/cached_network_image) is a Flutter package that provides a cached version of the `Image.network` widget. It helps in efficiently caching and displaying network images to reduce load times and improve performance.

7. **firebase_messaging: ^14.6.5**
   - [Firebase Messaging](https://pub.dev/packages/firebase_messaging) is a Flutter plugin that enables Firebase Cloud Messaging (FCM) in your app. It allows you to send and receive push notifications from Firebase Cloud Messaging.

8. **flutter_local_notifications: ^15.1.0+1**
   - [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications) is a Flutter package that allows you to display local notifications in your app. It enables you to show notifications even when the app is in the background or terminated.

## Getting Started

To use this project, ensure you have Flutter installed and set up on your development environment. You can clone this repository and run the following command to fetch the dependencies:

```bash
flutter pub get
```

After fetching the dependencies, you can use the packages in your app by importing them as needed. Refer to the individual package links provided above for detailed documentation and usage instructions.

Make sure to follow the specific setup and configuration instructions for Firebase services, as required by the `firebase_core` and `firebase_messaging` packages.

## License

This project is open-source and is licensed under the [MIT License](LICENSE). Feel free to use and modify it according to your needs.

---

Please note that the versions mentioned in the `pubspec.yaml` file at the time of writing this readme might not be the latest versions available. Make sure to check the respective package pages on pub.dev for the most up-to-date versions and compatibility information.