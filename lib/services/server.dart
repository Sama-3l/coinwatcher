// ignore_for_file: empty_catches, unused_local_variable

import 'dart:convert';
import 'package:coinwatcher/constants/env.dart';
import 'package:coinwatcher/data/model/expense.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServerAccess {
  String serverUrl = serverURL;

  Future<Map<String, dynamic>> register(
      User currentUser, SharedPreferences prefs) async {
    final url = Uri.parse('$serverUrl/post'); // Replace with your server URL
    try {
      var regBody = currentUser.toJSON();
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(regBody));
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseBody['status'] == '200') {
          prefs.setString("token", responseBody['token']);
          currentUser.id = JwtDecoder.decode(responseBody['token'])['_id'];
          return {"success": true, "code": responseBody['status']};
        } else {
          return {"success": false, "code": responseBody['status']};
        }
      } else {
        return {"success": false, "code": responseBody['status']};
      }
    } catch (e) {
      rethrow;
    }
  }

  dynamic login(Map<String, String> creds, SharedPreferences prefs) async {
    final url = Uri.parse('$serverUrl/login');
    final getDataUrl = Uri.parse('$serverUrl/getData');

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

  dynamic updateDailyBudget(User currentUser) async {
    final url = Uri.parse('$serverUrl/updateBudget');

    try {
      final response = await http.put(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            '_id': currentUser.id,
            'budget': currentUser.dailyBudget.toString()
          }));

      var responseBody = jsonDecode(response.body);
    } catch (e) {}
  }

  dynamic addExpense(User currentUser, Expense expense) async {
    final url = Uri.parse('$serverUrl/addExpense');
    try {
      final response = await http.put(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {'expense': expense.toJSON(), 'data': currentUser.toJSON()}));

      var responseBody = jsonDecode(response.body);
    } catch (e) {}
  }

  dynamic editExpense(Expense? originalExpense, Expense? currentExpense, User currentUser) async {
    final url = Uri.parse('$serverUrl/updateExpense');
    AllExpenses reversedAllExpenses = AllExpenses();
    reversedAllExpenses.allExpenses = currentUser.allExpenses.allExpenses.reversed.toList();
    try {
      final response = await http.put(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            '_id': currentUser.id,
            'originalExpense': originalExpense!.toJSON(),
            'currentExpense': currentExpense!.toJSON(),
            'allExpenses' : reversedAllExpenses.toJSON()
          }));
    } catch (e) {}
  }

  dynamic deleteExpense(String id, Expense? expense) async {
    final url = Uri.parse('$serverUrl/deleteExpense');
    try {
      final response = await http.put(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            '_id': id,
            'expense': expense!.toJSON(),
          }));
    } catch (e) {}
  }
}
