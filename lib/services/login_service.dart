import 'dart:convert';

import 'package:escolamobile/constants/routes.dart';
import 'package:escolamobile/services/pref_services.dart';
import 'package:http/http.dart' as http;

class LoginService {
  login(String email, String senha) async {
    http.Response response = await http.post(
      Uri.parse(Routes().logar()),
      body: json.encode({
        "email": email,
        "password": senha,
        "returnSecureToken": true,
      }),
    );
    if (response.statusCode == 200) {
      PrefServices.save(email);

      return true;
    }
    return false;
  }
}
