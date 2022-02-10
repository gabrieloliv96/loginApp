import 'dart:convert';

import 'package:escolamobile/constants/routes.dart';
import 'package:http/http.dart' as http;

class CadastrarService {
  cadastrar(String email, String senha) async {
    http.Response response = await http.post(
      Uri.parse(Routes().cadastrar()),
      body: json.encode({
        "email": email,
        "password": senha,
        "returnSecureToken": true,
      }),
    );

    print(response.body);
  }
}
