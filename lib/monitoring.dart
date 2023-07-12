// import 'dart:js' as js;
import 'dart:convert';
import 'dart:io';
import 'package:aplikasi_iot/home.dart';
import 'package:aplikasi_iot/kendali.dart';
import 'package:aplikasi_iot/network/api.dart';
import 'package:aplikasi_iot/otp.dart';
import 'package:aplikasi_iot/scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';

var connected = false;
var topic = '';
var idPerangkat = '';
var perangkat = null;

class home extends StatefulWidget {
  const home({super.key});
  @override
  State<home> createState() {
    connected = false;
    return _homeState();
  }
}

var client_id =
    'app-iot-monitoring' + DateTime.now().millisecondsSinceEpoch.toString();

// Web
final client = MqttBrowserClient('ws://test.mosquitto.org/mqtt', client_id);
// Apk
// final client = MqttServerClient('test.mosquitto.org', client_id);

var pongCount = 0; // Pong counter

bool kebakaran = false;
bool api = false;
bool asap = false;
var suhu = '0';
var kelembapan = '0';

final connMess = MqttConnectMessage()
    .withClientIdentifier(client_id)
    .withWillTopic('willtopic') // If you set this you must set a will message
    .withWillMessage('My Will message')
    .startClean() // Non persistent session for testing
    .withWillQos(MqttQos.atLeastOnce);

// void _makePhoneCall(String phoneNumber) {
//   js.context.callMethod('open', [phoneNumber]);
// }

var suksesGetPerangkat2 = false;

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    client.websocketProtocols = ['mqtt'];

    if (kIsWeb) {
      client.port = 8080;
    }
    if (selectedIndex != 0) {
      setState(() {});
    }
    void cekPerangkat() async {
      try {
        var res = await Network().getData("/user");
        var body = jsonDecode(res.body);

        print(body);

        List? perangkats =
            body['perangkats'] != null ? List.from(body['perangkats']) : null;

        if (perangkats != null && perangkats.length == 0) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: ((context) => ScannerPage())));
        } else {
          topic = perangkats![0]['qr_code'];
          idPerangkat = perangkats![0]['id'];
          perangkat = perangkats![0];

          final SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          await localStorage.setString('idPerangkat', idPerangkat);

          if (perangkat != null) {
            print('test');
            suksesGetPerangkat2 = true;
            setState(() {
              kebakaran = perangkat['kebakaran'].toString() == '1';
              asap = perangkat['asap'].toString() == '1';
              api = perangkat['api'].toString() == '1';
              suhu = perangkat['suhu'].toString();
              kelembapan = perangkat['kelembapan'].toString();
            });
          }
        }

        if (body['kode_otp'] != null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: ((context) => Otp())));
        }
      } catch (e) {}
    }

    if (!suksesGetPerangkat2 && idPerangkat == '') {
      cekPerangkat();
    } else {}
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

          if (key == 'kebakaran') {
            setState(() {
              kebakaran = value;
            });
          }
          if (key == 'api') {
            setState(() {
              api = value;
            });
          }
          if (key == 'asap') {
            setState(() {
              asap = value;
            });
          }
          if (key == 'suhu') {
            setState(() {
              suhu = value.toString();
            });
          }
          if (key == 'kelembapan') {
            setState(() {
              kelembapan = value.toString();
            });
          }

          if (key == 'lampu') {
            isSwitched1 = value;
          }
          if (key == 'kipas') {
            isSwitched2 = value;
          }
          if (key == 'pintu') {
            isSwitched3 = value;
          }
          if (key == 'pompa') {
            isSwitched4 = value;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                child: Column(
                  children: [
                    Text(
                      'Smart Home',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Card(
                        color: kebakaran ? Colors.red : Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18)),
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
                                    color:
                                        kebakaran ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(13),
                                child: Text(
                                  kebakaran ? 'ON' : 'OFF',
                                  style: TextStyle(
                                      color: kebakaran
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
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
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: Card(
                              color: asap ? Colors.red : Colors.blue,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                  Text(asap ? 'ON' : 'OFF',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green),
                                onPressed: () {
                                  // _makePhoneCall('tel:113');
                                  // final url = Uri(scheme: 'tel', path: '113');
                                  // await canLaunchUrl(
                                  //   url,
                                  // );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: Card(
                              color: api ? Colors.red : Colors.blue,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                  Text(api ? 'ON' : 'OFF',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))
                                ],
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
                                  const BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.23,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    suhu.toString() + '°',
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
                          Card(
                            color: Color(0xff3892FB),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.23,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    kelembapan.toString() + '°',
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
                        ],
                      ),
                    ),
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
