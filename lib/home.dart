import 'dart:js' as js;
import 'package:aplikasi_iot/kendali.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';

class home extends StatefulWidget {
  const home({super.key});
  @override
  State<home> createState() => _homeState();
}

void _makePhoneCall(String phoneNumber) {
  js.context.callMethod('open', [phoneNumber]);
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB4C1D8),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/banner.png',
                  height: 300,
                ),
              ),
              Text(
                'SMART HOME',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Status Kebakaran',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'OFF',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      color: Color(0xff3892FB),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(35),
                          child: Column(
                            children: [
                              Text(
                                'Asap',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text('OFF',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () {
                          _makePhoneCall('tel:113');
                          // final url = Uri(scheme: 'tel', path: '113');
                          // await canLaunchUrl(
                          //   url,
                          // );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 35, bottom: 35, left: 15, right: 15),
                          child: Column(
                            children: [
                              Text(
                                'Darurat',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Icon(
                                Icons.phone,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Color(0xff3892FB),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(35),
                          child: Column(
                            children: [
                              Text(
                                'Api',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text('OFF',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      color: Color(0xff3892FB),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(50),
                          child: Column(
                            children: [
                              Text(
                                '26°',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              Image.asset('assets/images/temperature.png'),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Suhu',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Color(0xff3892FB),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 55, bottom: 55, left: 25, right: 25),
                          child: Column(
                            children: [
                              Text(
                                '26°',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.water_drop,
                                size: 50,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Kelembapan',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                color: Color(0xff3892FB),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    margin: EdgeInsets.only(right: 40, left: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: (() => {}),
                          icon: Icon(Icons.home),
                          iconSize: 35,
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: (() => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Kendali()))),
                              }),
                          icon: Icon(Icons.menu),
                          iconSize: 35,
                          color: Color(0xffB4C1D8),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
