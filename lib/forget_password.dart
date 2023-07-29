import 'dart:convert';

import 'package:aplikasi_iot/home.dart';
import 'package:aplikasi_iot/network/api.dart';
import 'package:aplikasi_iot/otp_password.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forget_password extends StatefulWidget {
  const Forget_password({Key? key}) : super(key: key);

  @override
  _Forget_password createState() => _Forget_password();
}

class _Forget_password extends State<Forget_password> {
  final _formKey = GlobalKey<FormState>();
  final _forget_passwordcontroller = TextEditingController(text: '');

  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();

    fToast.init(context);
  }

  @override
  void sendOtppassword() async {
    var data = {
      'email': _forget_passwordcontroller.text,
    };

    print(data);

    var res = await Network().postData('/send-rest-password', data);
    var body = json.decode(res.body);
    print(res.body);

    if (body['success'] != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: ((context) =>
              Otp_password(email: _forget_passwordcontroller.text))));

      print("sukses");
    } else {
      Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.redAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.close),
            SizedBox(
              width: 12.0,
            ),
            Text("Email Salah"),
          ],
        ),
      );

      fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
      );
    }
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
                                  controller: _forget_passwordcontroller,
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
                                    labelText: 'Email Address',
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
