import 'dart:convert';

import 'package:aplikasi_iot/login.dart';
import 'package:aplikasi_iot/monitoring.dart';
import 'package:aplikasi_iot/network/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var name = '';
  var email = '';

  void get_data() async {
    try {
      var res = await Network().getData("/user");
      var body = jsonDecode(res.body);

      print(body);

      setState(() {
        name = body['name'];
        email = body['email'];
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    get_data();
    return Container(
      padding: EdgeInsets.only(top: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.70,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.blue),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      // Container(
                      //   height: 1,
                      // ),
                      Text(
                        email,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(height: 300),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Material(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white70,
                          child: InkWell(
                            onTap: () async {
                              Network().postData('/logout', {});
                              var localStorage =
                                  await SharedPreferences.getInstance();
                              localStorage.remove('token');
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: ((context) => Login())),
                              );
                            },
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              // height: MediaQuery.of(context).size.height * 0.10,
                              // width: MediaQuery.of(context).size.width * 0.90,
                              width: 300,
                              height: 50,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blueAccent),
                                    ),
                                  ),
                                  Icon(Icons.logout, color: Colors.blueAccent),
                                  SizedBox(width: 8),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 50),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Material(
          //     borderRadius: BorderRadius.circular(25),
          //     color: Color(0xff3892FB),
          //     child: InkWell(
          //       onTap: () async {
          //         Network().postData('/logout', {});
          //         var localStorage = await SharedPreferences.getInstance();
          //         localStorage.remove('token');
          //         Navigator.of(context).pushReplacement(
          //           MaterialPageRoute(builder: ((context) => Login())),
          //         );
          //       },
          //       borderRadius: BorderRadius.circular(25),
          //       child: Container(
          //         width: 250,
          //         height: 50,
          //         alignment: Alignment.center,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Icon(Icons.logout, color: Colors.white70),
          //             SizedBox(width: 8),
          //             Text(
          //               'Logout',
          //               style: TextStyle(
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.w700,
          //                   color: Colors.white),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
