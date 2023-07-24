import 'package:assignment/functions/helper_methods.dart';
import 'package:assignment/screens/notification_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
}

// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications',
          // Replace with your custom icon name or drawable resource
        ),
      ),
    );
  }
}

//Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class PushNotification {
  static Future initialize(BuildContext context) async {
    await Firebase.initializeApp();
    //subscribe to topic "app"

    // get fcm token
    String? token = await FirebaseMessaging.instance.getToken();
    print('token: $token');
    FirebaseMessaging.instance.subscribeToTopic('app');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await setupFlutterNotifications();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // showFlutterNotification(message);
      print('Got a message whilst in the foreground!');
      HelperMethods.navigateTo(context, const NotificationScreen(), 1);
    });

    // on message open app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // showFlutterNotification(message);
      HelperMethods.navigateTo(context, const NotificationScreen(), 1);
    });

    // on terminated state open app

    await FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        // showFlutterNotification(message);
        HelperMethods.navigateTo(context, const NotificationScreen(), 1);
      }
      return message;
    });
  }
}
