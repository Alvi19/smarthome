import 'dart:convert';
import 'package:aplikasi_iot/login.dart';
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
      title: 'Registation Form',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: RegistrationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

final _formKey = GlobalKey<FormState>();
final _emailcontroller = TextEditingController(text: '');
final _namacontroller = TextEditingController(text: '');
final _passwordcontroller = TextEditingController(text: '');
final _confirmpasswordcontroller = TextEditingController(text: '');

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    void _register() async {
      var data = {
        'name': _namacontroller.text,
        'email': _emailcontroller.text,
        'password': _passwordcontroller.text,
        'confirm_password': _confirmpasswordcontroller.text
      };

      print(data);
      
      var res = await Network().auth(data, '/register');
      var body = json.decode(res.body);
      // print(body);
      if (body['success']) {
        SharedPreferences localStorage;

        localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', json.encode(body['data']['token']));
        localStorage.setString('user', json.encode(body['data']['nama']));

        Navigator.of(context)
          ..pushReplacement(MaterialPageRoute(
              builder: ((context) =>
                  Login())));
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder:context) => const DetailPage(title: "gvg", desc: "juj");
        // );
        print("sukses");
      } else {}
    }

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Image.asset(
                  'assets/images/banner.png',
                  height: 400,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                transform: Matrix4.translationValues(0, -50, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Sign UP',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                                controller: _namacontroller,
                                decoration: InputDecoration(
                                  labelText: 'Nama',
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? "Perlu di isi" : null),
                            const SizedBox(height: 10),
                            TextFormField(
                                controller: _emailcontroller,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? "Perlu di isi" : null),
                            SizedBox(height: 10),
                            TextFormField(
                                controller: _passwordcontroller,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                ),
                                obscureText: true,
                                validator: (value) =>
                                    value!.isEmpty ? "Perlu di isi" : null),
                            SizedBox(height: 10),
                            TextFormField(
                                controller: _confirmpasswordcontroller,
                                decoration: InputDecoration(
                                  labelText: 'konfirmasi Password',
                                ),
                                obscureText: true,
                                validator: (value) =>
                                    value!.isEmpty ? "Perlu di isi" : null),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _register();
                                }
                                // Kode untuk menangani submit form
                              },
                              child: Text('DAFTAR'),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
