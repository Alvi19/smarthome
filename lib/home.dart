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

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    home(),
    Kendali(),
    Text(
      'History',
      style: optionStyle,
    ),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void cekPerangkat() async {
    var res = await Network().getData("/user");
    var body = jsonDecode(res.body);

    print(body);

    List? perangkats =
        body['perangkats'] != null ? List.from(body['perangkats']) : null;

    if (perangkats != null && perangkats.length == 0) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => ScannerPage())));
    }

    if (body['kode_otp'] != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) => Otp())));
    }
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
    cekPerangkat();
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: IconThemeData(color: Colors.white70),
        selectedIconTheme: IconThemeData(color: Colors.white),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Monitoring',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(SliderIcon.sliders),
            label: 'Control',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
