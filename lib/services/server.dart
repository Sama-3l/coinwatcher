// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinwatcher/data/model/user.dart' as UserModel;
import 'package:coinwatcher/data/repositories/allExpenses.dart';

class ServerAccess {
  // String serverUrl = serverURL;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<Map<String, dynamic>> register(
  //     User currentUser, SharedPreferences prefs) async {
  //   final url = Uri.parse('$serverUrl/post'); // Replace with your server URL
  //   try {
  //     var regBody = currentUser.toJSON();
  //     final response = await http.post(url,
  //         headers: {'Content-Type': 'application/json'},
  //         body: jsonEncode(regBody));
  //     var responseBody = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       if (responseBody['status'] == '200') {
  //         prefs.setString("token", responseBody['token']);
  //         currentUser.id = JwtDecoder.decode(responseBody['token'])['_id'];
  //         return {"success": true, "code": responseBody['status']};
  //       } else {
  //         return {"success": false, "code": responseBody['status']};
  //       }
  //     } else {
  //       return {"success": false, "code": responseBody['status']};
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // dynamic login(Map<String, String> creds, SharedPreferences prefs) async {
  //   final url = Uri.parse('$serverUrl/login');
  //   final getDataUrl = Uri.parse('$serverUrl/getData');

  //   try {
  //     final response = await http.post(url,
  //         headers: {'Content-Type': 'application/json'},
  //         body: jsonEncode(creds));

  //     var responseBody = jsonDecode(response.body);
  //     prefs.setString('token', responseBody['token']);

  //     if (response.statusCode == 200) {
  //       // Request successful, handle the response data here
  //       final appData = await http.post(getDataUrl,
  //           headers: {'Content-Type': 'application/json'},
  //           body: jsonEncode(creds));
  //       final decodedData = jsonDecode(appData.body);
  //       return decodedData;
  //     } else {
  //       // Request failed, handle the error here
  //       return null;
  //     }
  //   } catch (e) {
  //     // An error occurred while making the request
  //   }
  // }

  // dynamic tokenLogin(Map<String, dynamic> creds) async {
  //   final url = Uri.parse('$serverUrl/login');
  //   final getDataUrl = Uri.parse('$serverUrl/getData');

  //   try {
  //     final response = await http.post(url,
  //         headers: {'Content-Type': 'application/json'},
  //         body: jsonEncode(creds));

  //     if (response.statusCode == 200) {
  //       // Request successful, handle the response data here
  //       final appData = await http.post(getDataUrl,
  //           headers: {'Content-Type': 'application/json'},
  //           body: jsonEncode(creds));
  //       final decodedData = jsonDecode(appData.body);
  //       return decodedData;
  //     } else {
  //       // Request failed, handle the error here
  //       return null;
  //     }
  //   } catch (e) {
  //     // An error occurred while making the request
  //   }
  // }

  dynamic updateDailyBudget(UserModel.User currentUser) async {
    try {
      // Update the user's document by adding the new expense to the allExpenses array
      await _firestore.collection('users').doc(currentUser.id).update({
        'dailyBudget': currentUser.dailyBudget,
      });

      print('Expense added successfully');
    } catch (e) {
      print('Error adding expense: $e');
    }
  }

  dynamic editExpenseList(UserModel.User currentUser) async {
    // final url = Uri.parse('$serverUrl/addExpense');
    try {
      // Update the user's document by adding the new expense to the allExpenses array
      AllExpenses reversedAllExpenses = AllExpenses();
      reversedAllExpenses.allExpenses = currentUser.allExpenses.allExpenses.reversed.toList();
      await _firestore.collection('users').doc(currentUser.id).update({
        'allExpenses': reversedAllExpenses.toJSON(),
      });

      print('Expense added successfully');
    } catch (e) {
      print('Error adding expense: $e');
    }
  }

  // dynamic deleteExpense(String id, Expense? expense) async {
  //   // final url = Uri.parse('$serverUrl/deleteExpense');
  //   try {
  //     final response = await http.put(url,
  //         headers: {
  //           'Content-Type': 'application/json'
  //         },
  //         body: jsonEncode({
  //           '_id': id,
  //           'expense': expense!.toJSON(),
  //         }));
  //   } catch (e) {}
  // }
}
