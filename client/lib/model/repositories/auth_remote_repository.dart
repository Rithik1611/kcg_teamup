import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<bool> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    var url = 'http://192.168.137.197:5000/api/auth/register';
    final response = await http.post(
      Uri.parse(url), // Replace with your backend URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
      // Successful user creation
      return true;
    } else if (response.statusCode == 400) {
      // Email already exists
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData['message']); // Prints "Email already exists"
      return false;
    } else {
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(
          'https://your-backend-url.com/login'), // Replace with your backend URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      // Assuming the response contains a 'success' field
      return responseData['success'] ?? false;
    } else {
      // Handle error
      return false;
    }
  }
}
