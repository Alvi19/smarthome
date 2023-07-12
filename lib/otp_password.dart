import 'dart:convert';

import 'package:aplikasi_iot/home.dart';
import 'package:aplikasi_iot/network/api.dart';
import 'package:aplikasi_iot/reset.password.dart';
import 'package:flutter/material.dart';

class Otp_password extends StatefulWidget {
  final String email;
  const Otp_password({Key? key, required this.email}) : super(key: key);

  @override
  _OtpPasswordState createState() => _OtpPasswordState();
}

class _OtpPasswordState extends State<Otp_password> {
  final _formKey = GlobalKey<FormState>();
  final _otpcontroller = TextEditingController(text: '');

  @override
  void sendOtppassword() async {
    var data = {
      'otp': _otpcontroller.text,
      'email': widget.email,
    };

    print(data);

    var res = await Network().postData('/send-rest-password', data);
    var body = json.decode(res.body);
    print(res.body);

    if (body['success']) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: ((context) => Reset_password(
                email: widget.email,
                otp: _otpcontroller.text,
              ))));

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'OTP Verification',
                      style: TextStyle(
                        fontSize: 30,
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
                                  controller: _otpcontroller,
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
                                    labelText: 'kode OTP',
                                    filled: true,
                                    fillColor: Color(0xffd9d9d9),
                                  ),
                                  validator: (value) =>
                                      value!.isEmpty ? "Perlu di isi" : null),
                            ),
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
                                    sendOtppassword();
                                  }
                                  // Kode untuk menangani submit form
                                },
                                child: Text(
                                  'Verify',
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
