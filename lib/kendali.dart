import 'package:aplikasi_iot/home.dart';
import 'package:flutter/material.dart';

class Kendali extends StatefulWidget {
  const Kendali({Key? key}) : super(key: key);

  @override
  _KendaliState createState() => _KendaliState();
}

class _KendaliState extends State<Kendali> {
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
                              Image.asset(
                                'assets/images/energy.png',
                                width: 50,
                              ),
                              Text(
                                'Lampu',
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
                          padding: const EdgeInsets.all(50),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/fan-1.png',
                                width: 50,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Kipas',
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
                              Image.asset(
                                'assets/images/fan-1.png',
                                width: 50,
                              ),
                              Text(
                                'Pintu',
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
                              top: 50, bottom: 50, left: 28, right: 28),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/fan-1.png',
                                width: 50,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Pompa  Air',
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
                          onPressed: (() => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => home()))),
                              }),
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
