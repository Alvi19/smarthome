import 'dart:convert';
import 'package:aplikasi_iot/home.dart';
import 'package:aplikasi_iot/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'network/api.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController(text: '');
  final _namacontroller = TextEditingController(text: '');
  final _passwordcontroller = TextEditingController(text: '');
  final _confirmpasswordcontroller = TextEditingController(text: '');

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

      // log(body);
      print(body);

      print(res.statusCode);
      if (res.statusCode != 200) {
      } else if (body['success']) {
        SharedPreferences localStorage;

        print(body['data']['token']);

        localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', body['data']['token'].toString());
        localStorage.setString('user', body['data']['nama'].toString());

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: ((context) => BottomNavigationBarExample())));

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
                                  labelText: 'Nama',
                                  filled: true,
                                  fillColor: Color(0xffd9d9d9),
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? "Perlu di isi" : null),
                            const SizedBox(height: 10),
                            TextFormField(
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
                            SizedBox(height: 10),
                            TextFormField(
                                controller: _confirmpasswordcontroller,
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
                                  labelText: 'Konfirmasi Password',
                                  filled: true,
                                  fillColor: Color(0xffd9d9d9),
                                ),
                                obscureText: true,
                                validator: (value) => value!.isEmpty
                                    ? "Perlu di isi"
                                    : value! != _passwordcontroller.text
                                        ? "Password  tidak sama"
                                        : null),
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
                                    _register();
                                  }
                                  // Kode untuk menangani submit form
                                },
                                child: Text(
                                  'Daftar',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
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
