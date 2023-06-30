import 'dart:convert';
import 'dart:io';

import 'package:aplikasi_iot/home.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

var connected = false;

class Kendali extends StatefulWidget {
  const Kendali({Key? key}) : super(key: key);

  @override
  _KendaliState createState() {
    connected = false;
    return _KendaliState();
  }
}

final client = MqttServerClient('broker.emqx.io', '');
var pongCount = 0; // Pong counter

var topic = 'iot-app-90';

// bool isSwitched = false;
bool isSwitched1 = false;
bool isSwitched2 = false;
bool isSwitched3 = false;
bool isSwitched4 = false;

final connMess = MqttConnectMessage()
    .withClientIdentifier('Android')
    .withWillTopic('willtopic') // If you set this you must set a will message
    .withWillMessage('My Will message')
    .startClean() // Non persistent session for testing
    .withWillQos(MqttQos.atLeastOnce);

class _KendaliState extends State<Kendali> {
  @override
  Widget build(BuildContext context) {
    void onSubscribed(String topic) {
      print('EXAMPLE::Subscription confirmed for topic $topic');
    }

    void onDisconnected() {
      connected = false;
    }

    void onConnected() {
      try {
        client.subscribe(topic, MqttQos.atMostOnce);
        client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
          final recMess = c![0].payload as MqttPublishMessage;
          final pt =
              MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

          final data = json.decode(pt);
          var key = '';
          var value = null;
          data.forEach((key1, value1) {
            key = key1;
            value = value1;
          });

          if (key == 'lampu') {
            setState(() {
              isSwitched1 = value;
            });
          }
          if (key == 'kipas') {
            setState(() {
              isSwitched2 = value;
            });
          }
          if (key == 'pintu') {
            setState(() {
              isSwitched3 = value;
            });
          }
          if (key == 'pump') {
            setState(() {
              isSwitched4 = value;
            });
          }
          print(
              'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
          print('');
        });
      } catch (e) {}

      print(
          'EXAMPLE::OnConnected client callback - Client connection was successful');
    }

    Future<void> connect() async {
      try {
        print('mencoba konek');
        await client.connect();

        connected = true;
      } on NoConnectionException catch (e) {
        // Raised by the client when connection fails.
        print('EXAMPLE::client exception - $e');
        client.disconnect();
      } on SocketException catch (e) {
        // Raised by the socket layer
        print('EXAMPLE::socket exception - $e');
        client.disconnect();
      }
    }

    if (!connected) {
      client.connectionMessage = connMess;
      client.onConnected = onConnected;
      client.onDisconnected = onDisconnected;
      client.onSubscribed = onSubscribed;

      print('mencobaa konek2');
      connect();
    }

    return Scaffold(
      backgroundColor: Color(0xffB4C1D8),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 20),
                  child: Image.asset(
                    'assets/images/banner.png',
                    height: 300,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.60,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Card(
                              // color: Color(0xff3892FB),
                              color: isSwitched1 ? Colors.blue : Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    child: Icon(
                                      Icons.light_sharp,
                                      size: 50,
                                      color: isSwitched1
                                          ? Colors.white
                                          : Colors.blue,
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
                                        final builder =
                                            MqttClientPayloadBuilder();
                                        builder.addString(
                                            jsonEncode({'lampu': value}));

                                        try {
                                          client.publishMessage(
                                              topic,
                                              MqttQos.exactlyOnce,
                                              builder.payload!);
                                        } on ConnectionException catch (e) {}
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
                          Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Card(
                              // color: Color(0xff3892FB),
                              color: isSwitched2 ? Colors.blue : Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    child: Icon(
                                      Icons.ac_unit_sharp,
                                      size: 50,
                                      color: isSwitched2
                                          ? Colors.white
                                          : Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    'Kipas',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Switch(
                                    value: isSwitched2,
                                    onChanged: (value) {
                                      setState(() {
                                        final builder =
                                            MqttClientPayloadBuilder();
                                        builder.addString(
                                            jsonEncode({'kipas': value}));

                                        try {
                                          client.publishMessage(
                                              topic,
                                              MqttQos.exactlyOnce,
                                              builder.payload!);
                                        } on ConnectionException catch (e) {}
                                      });
                                    },
                                    activeColor:
                                        const Color.fromARGB(255, 72, 248, 78),
                                    inactiveThumbColor: Colors.lightBlue,
                                    inactiveTrackColor:
                                        Colors.grey.withOpacity(0.50),
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
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Card(
                              // color: Color(0xff3892FB),
                              color: isSwitched3 ? Colors.blue : Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    child: Icon(
                                      Icons.door_sliding_rounded,
                                      size: 50,
                                      color: isSwitched3
                                          ? Colors.white
                                          : Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    'Pintu',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Switch(
                                    value: isSwitched3,
                                    onChanged: (value) {
                                      setState(() {
                                        final builder =
                                            MqttClientPayloadBuilder();
                                        builder.addString(
                                            jsonEncode({'pintu': value}));

                                        try {
                                          client.publishMessage(
                                              topic,
                                              MqttQos.exactlyOnce,
                                              builder.payload!);
                                        } on ConnectionException catch (e) {}
                                      });
                                    },
                                    activeColor:
                                        const Color.fromARGB(255, 72, 248, 78),
                                    inactiveThumbColor: Colors.lightBlue,
                                    inactiveTrackColor:
                                        Colors.grey.withOpacity(0.50),
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
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Card(
                              // color: Color(0xff3892FB),
                              color: isSwitched4 ? Colors.blue : Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    child: Icon(
                                      Icons.heat_pump_outlined,
                                      size: 50,
                                      color: isSwitched4
                                          ? Colors.white
                                          : Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    'Pump',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Switch(
                                    value: isSwitched4,
                                    onChanged: (value) {
                                      setState(() {
                                        final builder =
                                            MqttClientPayloadBuilder();
                                        builder.addString(
                                            jsonEncode({'pump': value}));

                                        try {
                                          client.publishMessage(
                                              topic,
                                              MqttQos.exactlyOnce,
                                              builder.payload!);
                                        } on ConnectionException catch (e) {}
                                      });
                                    },
                                    activeColor:
                                        const Color.fromARGB(255, 72, 248, 78),
                                    inactiveThumbColor: Colors.lightBlue,
                                    inactiveTrackColor:
                                        Colors.grey.withOpacity(0.50),
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
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: ((context) => home()))),
                              }),
                          icon: Icon(Icons.home),
                          iconSize: 35,
                          color: Color(0xffB4C1D8),
                        ),
                        IconButton(
                          onPressed: (() => {}),
                          icon: Icon(Icons.menu),
                          iconSize: 35,
                          color: Colors.white,
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
