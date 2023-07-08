import 'package:aplikasi_iot/login.dart';
import 'package:aplikasi_iot/network/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.blue,
            child: SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('NAMA'), Text('Email')],
              ),
            ),
          ),
          Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff0075ff)),
            child: ElevatedButton(
              onPressed: () async {
                Network().postData('/logout', {});
                var localStorage = await SharedPreferences.getInstance();
                localStorage.remove('token');
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => Login())));
              },
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
