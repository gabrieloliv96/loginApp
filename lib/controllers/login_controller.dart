import 'package:escolamobile/services/login_service.dart';
import 'package:flutter/widgets.dart';

class LoginController {
  ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);

  String? _login;
  setLogin(String value) => _login = value;

  String? _senha;
  setSenha(String value) => _senha = value;

  Future<bool> auth() async {
    return await LoginService().login(
      _login.toString(),
      _senha.toString(),
    );
  }
}
