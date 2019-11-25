import 'package:http/http.dart' as http;

class LoginService {
  static Future callLogin(String email, String password) async {
    final response = await http.post(
      "http://192.168.15.64:3000/auth/login",
      body: {
        "email": "saulo@test.com",
        "password": '97674691',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("error");
    }
  }
}
