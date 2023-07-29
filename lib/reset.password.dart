import 'dart:convert';

import 'package:aplikasi_iot/home.dart';
import 'package:aplikasi_iot/login.dart';
import 'package:aplikasi_iot/network/api.dart';
import 'package:aplikasi_iot/otp_password.dart';
import 'package:flutter/material.dart';

class Reset_password extends StatefulWidget {
  final String email;
  final String otp;

  const Reset_password({Key? key, required this.email, required this.otp})
      : super(key: key);

  @override
  _Reset_password createState() => _Reset_password();
}

class _Reset_password extends State<Reset_password> {
  final _formKey = GlobalKey<FormState>();
  final _passwordcontroller = TextEditingController(text: '');
  final _confirmpasswordcontroller = TextEditingController(text: '');

  @override
  void sendPassword() async {
    var data = {
      'password': _passwordcontroller.text,
      'confirm_password': _confirmpasswordcontroller.text,
      'email': widget.email,
      'otp': widget.otp,
    };

    print(data);

    var res = await Network().postData('/send-rest-password', data);
    var body = json.decode(res.body);
    print(res.body);

    if (body['success']) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) => Login())));

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
                      'Forget Password',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              child: TextFormField(
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
                                  validator: (value) =>
                                      value!.isEmpty ? "Perlu di isi" : null),
                            ),
                            SizedBox(height: 25),
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
                                validator: (value) => value!.isEmpty
                                    ? "Perlu di isi"
                                    : value! != _passwordcontroller.text
                                        ? "Password tidak sama"
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
                                    sendPassword();
                                  }
                                },
                                child: Text(
                                  'Kirim',
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
