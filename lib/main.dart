import 'dart:convert';
import 'dart:developer';
import 'package:aplikasi_iot/home.dart';
import 'package:aplikasi_iot/monitoring.dart';
import 'package:aplikasi_iot/icons/slider_icons.dart';
import 'package:aplikasi_iot/kendali.dart';
import 'package:aplikasi_iot/login.dart';
import 'package:aplikasi_iot/otp.dart';
import 'package:aplikasi_iot/scanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'network/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smarthome',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BottomNavigationBarExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}
