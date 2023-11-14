// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;

// // make a GET request to the API endpoint that provides user details.

// class SearchAPI {
//   Future<Map<String, dynamic>> searchStudent(String StudentNumber) async {
//     final response = await http.get(
//         Uri.parse('http://10.2.23.102:8888/api/users/student/0$StudentNumber'));

//     if (response.statusCode == 200) {
//       return json.decoder(response.body);
//     } else {
//       throw Exception('Failed to load the student information');
//     }
//   }
// }
