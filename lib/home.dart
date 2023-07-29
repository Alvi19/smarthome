import 'dart:convert';
import 'dart:developer';
import 'package:aplikasi_iot/monitoring.dart';
import 'package:aplikasi_iot/icons/slider_icons.dart';
import 'package:aplikasi_iot/kendali.dart';
import 'package:aplikasi_iot/login.dart';
import 'package:aplikasi_iot/otp.dart';
import 'package:aplikasi_iot/profile.dart';
import 'package:aplikasi_iot/scanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'network/api.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

int selectedIndex = 0;

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    home(),
    Kendali(),
    // Text(
    //   'History',
    //   style: optionStyle,
    // ),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void isLogin() async {
    var _isLogin = await Network().isLogin();

    if (!_isLogin) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) => Login())));
    }
  }

  @override
  Widget build(BuildContext context) {
    isLogin();
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: IconThemeData(color: Colors.white70),
        selectedIconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Monitoring',
          ),
          BottomNavigationBarItem(
            icon: Icon(SliderIcon.sliders),
            label: 'Control',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.history),
          //   label: 'History',
          //   backgroundColor: Colors.blue,
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
