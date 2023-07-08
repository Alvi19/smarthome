import 'dart:convert';
import 'package:aplikasi_iot/Register.dart';
import 'package:aplikasi_iot/home.dart';
import 'package:aplikasi_iot/monitoring.dart';
import 'package:aplikasi_iot/scanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'network/api.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final _formKey = GlobalKey<FormState>();
final _emailcontroller = TextEditingController(text: '');
final _passwordcontroller = TextEditingController(text: '');

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
    print(res.body);

    if (body['success']) {
      SharedPreferences localStorage;
      localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['data']['token'].toString());
      localStorage.setString('user', body['data']['nama'].toString());

      Navigator.of(context)
        ..pushReplacement(MaterialPageRoute(
            builder: ((context) => BottomNavigationBarExample())));

      print("sukses");
    } else {}
  }

  void isLogin() async {
    var _isLogin = await Network().isLogin();

    if (_isLogin) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: ((context) => BottomNavigationBarExample())));
    }
  }

  Widget build(BuildContext context) {
    // isLogin();
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
                            Container(
                              child: TextFormField(
                                  controller: _emailcontroller,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 20),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffd9d9d9),
                                        width: 0,
                                      ),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    labelText: 'Email',
                                    filled: true,
                                    fillColor: Color(0xffd9d9d9),
                                  ),
                                  validator: (value) =>
                                      value!.isEmpty ? "Perlu di isi" : null),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                                controller: _passwordcontroller,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          20, 20, 20, 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffd9d9d9),
                                      width: 0,
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  labelText: 'Password',
                                  filled: true,
                                  fillColor: Color(0xffd9d9d9),
                                ),
                                obscureText: true,
                                validator: (value) =>
                                    value!.isEmpty ? "Perlu di isi" : null),
                            SizedBox(height: 25),
                            Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0xff0075ff)),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _login();
                                  }
                                  // Kode untuk menangani submit form
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Tidak punya Akun ?',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            RegistrationPage())));
                                // Kode untuk menangani submit form
                              },
                              child: Text(
                                'Daftar !',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue),
                              ),
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
