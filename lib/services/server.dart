import 'dart:convert';

import 'package:coinwatcher/data/model/expense.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServerAccess {
  void fetchDataFromServer(User currentUser) async {
    final url = Uri.parse(
        'http://172.17.1.107:3000/post'); // Replace with your server URL
    try {
      var regBody = currentUser.toJSON();
      final response = await http.post(url, headers: {'Content-Type' : 'application/json'}, body: jsonEncode(regBody));

      if (response.statusCode == 200) {
        // Request successful, handle the response data here
        print('Response: ${response.body}');
      } else {
        // Request failed, handle the error here
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // An error occurred while making the request
      print('Error: $e');
    }
  }
}
