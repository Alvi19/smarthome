import 'dart:convert';
import 'dart:io';

// import 'package:aplikasi_iot/home.dart';
import 'package:aplikasi_iot/home.dart';
import 'package:aplikasi_iot/monitoring.dart';
import 'package:aplikasi_iot/network/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';

var connected = false;

class Kendali extends StatefulWidget {
  const Kendali({Key? key}) : super(key: key);

  @override
  _KendaliState createState() {
    connected = false;
    return _KendaliState();
  }
}

var client_id =
    'app-iot-kendali' + DateTime.now().millisecondsSinceEpoch.toString();

// Web
final client = MqttBrowserClient('ws://test.mosquitto.org/mqtt', client_id);
// Apk
// final client = MqttServerClient('test.mosquitto.org', client_id);

var pongCount = 0; // Pong counter

// bool isSwitched = false;
bool isSwitched1 = false;
bool isSwitched2 = false;
bool isSwitched3 = false;
bool isSwitched4 = false;

final connMess = MqttConnectMessage()
    .withClientIdentifier(client_id)
    .withWillTopic('willtopic') // If you set this you must set a will message
    .withWillMessage('My Will message')
    .startClean() // Non persistent session for testing
    .withWillQos(MqttQos.atLeastOnce);

var suksesGetPerangkat = false;

class _KendaliState extends State<Kendali> {
  @override
  Widget build(BuildContext context) {
    if (selectedIndex != 1) {
      setState(() {});
    }
    void getPerangkat() async {
      final SharedPreferences localStorage =
          await SharedPreferences.getInstance();
      idPerangkat = await localStorage.getString('idPerangkat')!;
      var res = await Network().getData("/perangkat/" + idPerangkat);
      var body = jsonDecode(res.body);

      print(body);

      if (body['data'] != null) {
        print('test');
        suksesGetPerangkat = true;
        setState(() {
          isSwitched1 = body['data']['lampu'].toString() == '1';
          isSwitched2 = body['data']['kipas'].toString() == '1';
          isSwitched3 = body['data']['pintu'].toString() == '1';
          isSwitched4 = body['data']['pompa'].toString() == '1';
        });
      }
    }

    if (!suksesGetPerangkat) {
      getPerangkat();
    }

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
          if (key == 'pompa') {
            setState(() {
              isSwitched4 = value;
            });
          }

          if (key == 'kebakaran') {
            kebakaran = value;
          }
          if (key == 'api') {
            api = value;
          }
          if (key == 'asap') {
            asap = value;
          }
          if (key == 'suhu') {
            suhu = value.toString();
          }
          if (key == 'kelembapan') {
            kelembapan = value.toString();
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
        client.websocketProtocols = ['mqtt'];

        if (kIsWeb) {
          client.port = 8080;
        }
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
                child: Column(
                  children: [
                    Container(
                      height: 45,
                    ),
                    Image.asset(
                      'assets/images/banner.png',
                      height: 180,
                    ),
                  ],
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
                                    const BorderRadius.all(Radius.circular(30)),
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
                                        print("sebelum publish ");
                                        try {
                                          client.publishMessage(
                                              topic,
                                              MqttQos.exactlyOnce,
                                              builder.payload!);
                                          print("setelah publish ");
                                        } on ConnectionException catch (e) {
                                          print(e);
                                        }
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
                              color: isSwitched2 ? Colors.blue : Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
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
                                    const BorderRadius.all(Radius.circular(30)),
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
                                    const BorderRadius.all(Radius.circular(30)),
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
                                    'Pump Air',
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
                                            jsonEncode({'pompa': value}));

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
            ],
          ),
        ),
      ),
    );
  }
}
