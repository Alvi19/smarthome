import 'dart:convert';
import 'package:aplikasi_iot/Register.dart';
import 'package:aplikasi_iot/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'network/api.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final _formKey = GlobalKey<FormState>();
final _emailcontroller = TextEditingController(text: '');
final _namacontroller = TextEditingController(text: '');
final _passwordcontroller = TextEditingController(text: '');
final _confirmpasswordcontroller = TextEditingController(text: '');

class _LoginState extends State<Login> {
  @override
  void _login() async {
    var data = {
      'email': _emailcontroller.text,
      'password': _passwordcontroller.text,
    };

    print(data);

    var res = await Network().auth(data, '/login');
    var body = json.decode(res.body);
    // print(body);

    if (body['success']) {
      SharedPreferences localStorage;
      localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['data']['token']));
      localStorage.setString('user', json.encode(body['data']['nama']));

      Navigator.of(context)
        ..pushReplacement(MaterialPageRoute(builder: ((context) => home())));

      print("sukses");
    } else {}
  }

  Widget build(BuildContext context) {
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
                      'Sign In',
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
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _login();
                                }
                                // Kode untuk menangani submit form
                              },
                              child: Text('Login'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            RegistrationPage())));
                                // Kode untuk menangani submit form
                              },
                              child: Text('Register'),
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
