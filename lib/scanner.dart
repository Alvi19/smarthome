import 'package:aplikasi_iot/monitoring.dart';
import 'package:aplikasi_iot/network/api.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import 'home.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.white70),
            ),
            onPressed: () async {
              var res = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SimpleBarcodeScannerPage(),
                  ));
              setState(() {
                if (res is String) {
                  result = res;
                  if (result.substring(0, 8) == 'app-iot-') {
                    Network().postData('/perangkat', {'qr_code': result});
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => BottomNavigationBarExample())));
                  }
                }
              });
            },
            child: const Text(
              'Scan QR Code',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      )),
    );
  }
}
