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
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('NAMA'), Text('Email')],
              ),
            ),
          ),
          SizedBox(height: 100),
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              borderRadius: BorderRadius.circular(25),
              color: Color(0xff3892FB),
              child: InkWell(
                onTap: () async {
                  Network().postData('/logout', {});
                  var localStorage = await SharedPreferences.getInstance();
                  localStorage.remove('token');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => Login())),
                  );
                },
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  width: 250,
                  height: 50,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.white70),
                      SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
