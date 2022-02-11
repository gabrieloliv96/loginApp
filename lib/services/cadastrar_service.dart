import 'dart:convert';

import 'package:escolamobile/constants/routes.dart';
import 'package:http/http.dart' as http;

class CadastrarService {
  cadastrar(String nome, String email, String senha) async {
    http.Response response = await http.post(
      Uri.parse(Routes().cadastrar()),
      body: json.encode({
        // "name": nome,
        "email": email,
        "password": senha,
        "returnSecureToken": true,
      }),
    );

    var url = Uri.https(
        'https://fir-teste-da4cc-default-rtdb.firebaseio.com/', 'users');
    // TODO dentro do controller tem que ser feito um save para o firebase só com o nome e email.
    await http.post(Uri.parse(url.toString()),
        body: json.encode({
          "name": nome,
          "email": email,
        }));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
