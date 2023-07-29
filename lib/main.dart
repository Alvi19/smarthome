import 'dart:convert';
import 'dart:developer';
import 'package:aplikasi_iot/home.dart';
import 'package:aplikasi_iot/messaging_service.dart';
import 'package:aplikasi_iot/monitoring.dart';
import 'package:aplikasi_iot/icons/slider_icons.dart';
import 'package:aplikasi_iot/kendali.dart';
import 'package:aplikasi_iot/login.dart';
import 'package:aplikasi_iot/otp.dart';
import 'package:aplikasi_iot/scanner.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'network/api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_messaging_web/firebase_messaging_web.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final messagingService = MessagingService();

  @override
  void initState() {
    super.initState();
    // messagingService.init();
  }

  void firebase() async {
    // WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);

    Network().postData('/send-fcm', {
      'fcm_token': fcmToken,
    });

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );

    // print('User granted permission: ${settings.authorizationStatus}');

    // WidgetsFlutterBinding.ensureInitialized();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });
  }

  // Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   await Firebase.initializeApp();
  //   print("Handling a background message: ${message.messageId}");
  // }

  @override
  Widget build(BuildContext context) {
    // firebase();
    return FlutterWebFrame(
      builder: (context) {
        return MaterialApp(
          builder: FToastBuilder(),
          title: 'Smarthome',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
          ),
          home: BottomNavigationBarExample(),
          debugShowCheckedModeBanner: false,
        );
      },
      maximumSize: Size(475.0, 812.0), // Maximum size
      enabled: kIsWeb, // default is enable, when disable content is full size
      backgroundColor: Colors.grey, // Background color/white space
    );
  }
}
