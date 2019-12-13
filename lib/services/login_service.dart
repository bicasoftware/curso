import 'dart:convert';

import 'package:curso/models/login_dto.dart';
import 'package:curso/services/response_error.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static const String baseUrl = "http://192.168.15.3:3000";

  static Future<dynamic> callLogin(String email, String password) async {
    final response = await http.post(
      "$baseUrl/auth/login",
      body: {
        "email": email,
        "password": password,
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

  static Future<dynamic> callCadastro(String email, String password) async {
    final response = await http.post(
      "$baseUrl/auth/signin",
      body: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      return ResponseError(
        error: json.decode(response.body)['error'],
        statusCode: response.statusCode,
      );
    }
  }

  static Future<dynamic> callUnregister(String email, String password) async {
    final response = await http.post(
      "$baseUrl/auth/unregister",
      body: {
        "email": email,
        "password": password,
      },
    );

    await handleResponse(response,
        on200: (Map<String, dynamic> json) => json['status'],
        onElse: (ResponseError error) => error);
  }

  static Future<dynamic> handleResponse(
    http.Response response, {
    Function(Map<String, dynamic> jsonBody) on200,
    Function(ResponseError error) onElse,
  }) async {
    if (response.statusCode == 200) {
      on200(json.decode(response.body));
    } else {
      onElse(
        ResponseError(error: json.decode(response.body)['error'], statusCode: response.statusCode),
      );
    }
  }
}
