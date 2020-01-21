import 'package:dio/dio.dart';

class ClientHelper {
  ClientHelper() {
    _dio = Dio();
    _dio.options.headers['Authorization'] = "Bearer $token";
  }

  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEyLCJpYXQiOjE1Nzk1NTUwMjh9.0XpNUHgctzJzrOFDJaWC6OUemOB2BePwJQ2hCgIE5G0";

  Dio _dio;

  Dio getDio() => _dio;
}
