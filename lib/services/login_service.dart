import 'dart:convert';

import 'package:curso/models/login_dto.dart';
import 'package:curso/services/response_error.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<dynamic> callLogin(String email, String password) async {
    final response = await http.post(
      "http://192.168.15.64:3000/auth/login",
      body: {
        "email": "saulo@test.com",
        "password": '97674691',
      },
    );

    if (response.statusCode == 200) {
      return LoginDto.fromJson(json.decode(response.body));
    } else {
      return ResponseError(
        error: json.decode(response.body)['error'],
        statusCode: response.statusCode,
      );
    }
  }
}
