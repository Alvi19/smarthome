import 'package:aplikasi_iot/home.dart';
import 'package:flutter/material.dart';

class Kendali extends StatefulWidget {
  const Kendali({Key? key}) : super(key: key);

  @override
  _KendaliState createState() => _KendaliState();
}

// bool isSwitched = false;
bool isSwitched1 = false;
bool isSwitched2 = false;
bool isSwitched3 = false;
bool isSwitched4 = false;

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
                      // color: Color(0xff3892FB),
                      color: isSwitched1 ? Colors.blue : Colors.white70,
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
                              AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                child: Icon(
                                  Icons.light_sharp,
                                  size: 50,
                                  color:
                                      isSwitched1 ? Colors.white : Colors.blue,
                                ),
                              ),
                              Text(
                                'Lampu',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: isSwitched1,
                                onChanged: (value) {
                                  setState(() {
                                    // isSwitched = value;
                                    isSwitched1 = value;
                                    isSwitched2 = false;
                                    isSwitched3 = false;
                                    isSwitched4 = false;
                                  });
                                },
                                activeColor:
                                    const Color.fromARGB(255, 72, 248, 78),
                                inactiveThumbColor: Colors.lightBlue,
                                inactiveTrackColor:
                                    Colors.grey.withOpacity(0.50),
                              ),
                              if (isSwitched1)
                                Text(
                                  'ON',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              if (!isSwitched1)
                                Text(
                                  'OFF',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      // color: Color(0xff3892FB),
                      color: isSwitched2 ? Colors.blue : Color(0xff3892FB),
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
                              Icon(
                                Icons.ac_unit_rounded,
                                size: 50,
                              ),
                              Text(
                                'Kipas',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: isSwitched2,
                                onChanged: (value) {
                                  setState(() {
                                    // isSwitched = value;
                                    isSwitched1 = false;
                                    isSwitched2 = value;
                                    isSwitched3 = false;
                                    isSwitched4 = false;
                                  });
                                },
                                activeColor:
                                    const Color.fromARGB(255, 72, 248, 78),
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor:
                                    Colors.white.withOpacity(0.9),
                              ),
                              if (isSwitched2)
                                Text(
                                  'ON',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              if (!isSwitched2)
                                Text(
                                  'OFF',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
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
                      // color: Color(0xff3892FB),
                      color: isSwitched3 ? Colors.blue : Color(0xff3892FB),
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
                              Icon(
                                Icons.door_sliding_rounded,
                                size: 50,
                              ),
                              Text(
                                'Pintu',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: isSwitched3,
                                onChanged: (value) {
                                  setState(() {
                                    // isSwitched = value;
                                    isSwitched1 = false;
                                    isSwitched2 = false;
                                    isSwitched3 = value;
                                    isSwitched4 = false;
                                  });
                                },
                                activeColor:
                                    const Color.fromARGB(255, 72, 248, 78),
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor:
                                    Colors.white.withOpacity(0.9),
                              ),
                              if (isSwitched3)
                                Text(
                                  'ON',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              if (!isSwitched3)
                                Text(
                                  'OFF',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      // color: Color(0xff3892FB),
                      color: isSwitched4 ? Colors.blue : Color(0xff3892FB),
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
                              Icon(
                                Icons.heat_pump_sharp,
                                size: 50,
                              ),
                              Text(
                                'Pump',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: isSwitched4,
                                onChanged: (value) {
                                  setState(() {
                                    // isSwitched = value;
                                    isSwitched1 = false;
                                    isSwitched2 = false;
                                    isSwitched3 = false;
                                    isSwitched4 = value;
                                  });
                                },
                                activeColor:
                                    const Color.fromARGB(255, 72, 248, 78),
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor:
                                    Colors.white.withOpacity(0.9),
                              ),
                              if (isSwitched4)
                                Text(
                                  'ON',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              if (!isSwitched4)
                                Text(
                                  'OFF',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
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
