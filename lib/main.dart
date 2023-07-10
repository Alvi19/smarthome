import 'dart:convert';
import 'dart:developer';
import 'package:aplikasi_iot/home.dart';
import 'package:aplikasi_iot/monitoring.dart';
import 'package:aplikasi_iot/icons/slider_icons.dart';
import 'package:aplikasi_iot/kendali.dart';
import 'package:aplikasi_iot/login.dart';
import 'package:aplikasi_iot/otp.dart';
import 'package:aplikasi_iot/scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'network/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterWebFrame(
      builder: (context) {
        return MaterialApp(
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
