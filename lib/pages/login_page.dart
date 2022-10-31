// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:escolamobile/constants/preferences_keys.dart';
import 'package:escolamobile/controllers/login_controller.dart';
import 'package:escolamobile/models/user_login_model.dart';
import 'package:escolamobile/pages/cadastrar_page.dart';
import 'package:escolamobile/pages/index_page.dart';
import 'package:escolamobile/services/login_service.dart';
import 'package:escolamobile/widgets/text_form_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool? _manterConectado = false;
  LoginController _controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Appbar'),
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.shade900,
              Colors.blue.shade900,
              Colors.blue.shade900,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              Icon(Icons.account_circle_rounded),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(color: (Colors.white), fontSize: 28),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      TextFormLoginWidget(
                        controller: _mailController,
                        icon: Icon(
                          Icons.person_pin_circle_rounded,
                          color: Colors.white,
                        ),
                        cor: Colors.white,
                        label: 'Usuario',
                        textInput: TextInputType.emailAddress,
                        onChangeController: _controller.setLogin,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormLoginWidget(
                        controller: _passwordController,
                        cor: Colors.white,
                        icon: Icon(
                          Icons.vpn_key_rounded,
                          color: Colors.white,
                        ),
                        label: 'Senha',
                        isObscure: true,
                        textInput: TextInputType.text,
                        onChangeController: _controller.setSenha,
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.white),
                    child: Checkbox(
                        value: _manterConectado,
                        activeColor: Colors.blue.shade900,
                        onChanged: (newValue) {
                          setState(() {
                            _manterConectado = newValue!;
                          });
                        }),
                  ),
                  //MANTENHA-ME CONECTADO NÃO FUNCIONA
                  // Text(
                  //   'Mantenha-me conectado',
                  //   style: TextStyle(color: Colors.white),
                  // ),
                  SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    child: Text(
                      'Esqueci minha senha',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton.extended(
                heroTag: "btnEntrar",
                extendedPadding: EdgeInsets.all(20.0),
                onPressed: () async {
                  _controller.auth().then((result) {
                    if (result) {
                      print('Chegou');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IndexPage(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Login ou senha invalidos.'),
                          duration: Duration(seconds: 4),
                        ),
                      );
                    }
                  });
                },
                label: Text(
                  'Entrar',
                ),
                backgroundColor: Colors.red.shade600,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: Colors.white70,
                ),
              ),
              FloatingActionButton.extended(
                heroTag: "btnCadastrar",
                extendedPadding: EdgeInsets.all(20.0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CadastrarPage()),
                  );
                },
                label: Text(
                  'Cadastrar',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                backgroundColor: Colors.orange.shade300,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _doLogin() {
    // if (_formKey.currentState!.validate()) {
    LoginService().login(
      _mailController.text,
      _passwordController.text,
    );

    // .then();
    // if (response.statusCode != 200) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text('Email ou senha invalida.')));
    // }
    // } else {
    //   print("invalido");
    // }

    // String mailForm = _mailController.text;
    // String passForm = _passwordController.text;

    // UserLoginModel? savedUser = await _getSavedUser();

    // if (mailForm == savedUser.email && passForm == savedUser.senha) {
    //   print('Sucess');
    // } else {
    //   print('Falha');
    // }
  }

  Future<UserLoginModel> _getSavedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUser = prefs.getString(PreferencesKeys.activeUser);
    // print(jsonUser);

    Map<String, dynamic> mapUser = json.decode(jsonUser!);
    UserLoginModel user = UserLoginModel.fromJson(mapUser);
    // print(user);

    return user;
  }
}
