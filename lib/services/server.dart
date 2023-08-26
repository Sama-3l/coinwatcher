import 'dart:convert';

import 'package:coinwatcher/data/model/expense.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServerAccess {
  // String serverUrl = 'https://coinwatcherbackend-production.up.railway.app';
  String serverUrl = 'http://172.17.0.200:3000';

  void register(User currentUser) async {
    final url = Uri.parse('$serverUrl/post'); // Replace with your server URL
    try {
      var regBody = currentUser.toJSON();
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(regBody));
      if (response.statusCode == 200) {
        // Request successful, handle the response data here
      } else {
        // Request failed, handle the error here
      }
    } catch (e) {
      // An error occurred while making the request
    }
  }

  dynamic login(Map<String, String> creds, SharedPreferences prefs) async {
    final url = Uri.parse('$serverUrl/login');
    final getDataUrl = Uri.parse('$serverUrl/getData');

    print(creds);

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(creds));

      var responseBody = jsonDecode(response.body);
      prefs.setString('token', responseBody['token']);

      if (response.statusCode == 200) {
        // Request successful, handle the response data here
        final appData = await http.post(getDataUrl,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(creds));
        final decodedData = jsonDecode(appData.body);
        return decodedData;
      } else {
        // Request failed, handle the error here
        return null;
      }
    } catch (e) {
      // An error occurred while making the request
    }
  }

  dynamic tokenLogin(Map<String, dynamic> creds) async {
    final url = Uri.parse('$serverUrl/login');
    final getDataUrl = Uri.parse('$serverUrl/getData');

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(creds));

      var responseBody = jsonDecode(response.body);
      Map<String, dynamic> data = JwtDecoder.decode(responseBody['token']);

      if (response.statusCode == 200) {
        // Request successful, handle the response data here
        final appData = await http.post(getDataUrl,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(creds));
        final decodedData = jsonDecode(appData.body);
        return decodedData;
      } else {
        // Request failed, handle the error here
        return null;
      }
    } catch (e) {
      // An error occurred while making the request
    }
  }
}
