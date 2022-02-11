import 'package:escolamobile/services/cadastrar_service.dart';
import 'package:escolamobile/services/login_service.dart';
import 'package:flutter/widgets.dart';

class CadastrarController {
  ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);

  String? _login;
  setLogin(String value) => _login = value;

  String? _senha;
  setSenha(String value) => _senha = value;

  String? _nome;
  setNome(String value) => _nome = value;

  Future<bool> cadastro() async {
    return await CadastrarService().cadastrar(
      _login.toString(),
      _senha.toString(),
      _nome.toString(),
    );
  }

  // Future<bool> auth() async {
  //   return await LoginService().login(
  //     _login.toString(),
  //     _senha.toString(),
  //   );
  // }
}
