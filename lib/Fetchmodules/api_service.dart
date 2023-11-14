import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// make a GET request to the API endpoint that provides user details.

class ApiService {
  //Initialized when an instance of APIService is created
  final FlutterSecureStorage storage;
  ApiService(this.storage);

  Future<Map<String, dynamic>> getUserDetailsAPI() async {
    final token = await storage.read(key: 'token');
    final studentid = await storage.read(key: 'std_id');
    // print('student_id: ${studentid}');

    // print('apiToken: ${token}');

    if (token != null) {
      try {
        final fetchresponse = await http.get(
          Uri.parse('http://172.20.10.2:8888/api/users/student/0$studentid'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );

        if (fetchresponse.statusCode == 200) {
          final passwordFromApi = json.decode(fetchresponse.body)['password'];
          await storage.write(
              key: 'password', value: passwordFromApi.toString());
          return json.decode(fetchresponse.body);
        } else {
          throw Exception('Failed to load user data from the api');
        }
      } catch (error) {
        print('Error fetching user data: $error');
        throw error;
      }
    } else {
      throw Exception('Null Token');
    }
  }
}
