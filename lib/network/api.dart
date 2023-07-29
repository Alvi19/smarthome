import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'https://api.alviridho.my.id/api';

  // 192.168.1.2 is my IP, change with your IP address
  var token;

  _getToken() async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    token = await localStorage.getString('token');
  }

  isLogin() async {
    await _getToken();
    return token != null;
  }

  auth(data, apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.post(
      Uri.parse(fullUrl),
      body: json.encode(data),
      headers: _setHeaders(),
    );
  }

  getData(apiURL) async {
    var fullUrl = _url + apiURL;
    await _getToken();
    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }

  postData(apiURL, data) async {
    var fullUrl = _url + apiURL;
    await _getToken();
    return await http.post(
      Uri.parse(fullUrl),
      body: json.encode(data),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/vnd.api+json',
        'Authorization': 'Bearer $token',
      };
}
