import 'dart:convert';

import 'package:escolamobile/constants/preferences_keys.dart';
import 'package:escolamobile/controllers/cadastrar_controller.dart';
import 'package:escolamobile/models/user_login_model.dart';
import 'package:escolamobile/services/cadastrar_service.dart';
import 'package:escolamobile/widgets/text_form_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CadastrarPage extends StatefulWidget {
  const CadastrarPage({Key? key}) : super(key: key);

  @override
  _CadastrarPageState createState() => _CadastrarPageState();
}

class _CadastrarPageState extends State<CadastrarPage>
    with TickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  CadastrarController _controller = CadastrarController();

  late AnimationController _progressController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
  );

  Uri url = Uri.https(
      'fir-teste-da4cc-default-rtdb.firebaseio.com', '/cadastros.json');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastrar',
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade900,
                Colors.blue.shade800,
                Colors.red.shade300
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: (_isLoading)
          ? Container(
              color: Colors.blue.shade800,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding:
                    const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade900,
                      Colors.red.shade200,
                    ],
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Icon(Icons.account_circle_rounded),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormLoginWidget(
                          // controller: _nameController,
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          cor: Colors.white,
                          label: 'Nome completo',
                          textInput: TextInputType.name,
                          onChangeController: _controller.setNome,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormLoginWidget(
                          // controller: _mailController,
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          cor: Colors.white,
                          label: 'Email',
                          textInput: TextInputType.emailAddress,
                          onChangeController: _controller.setLogin,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // // TextFormLoginWidget(
                        // //   icon: const Icon(
                        // //     Icons.person,
                        // //     color: Colors.white,
                        // //   ),
                        // //   cor: Colors.white,
                        // //   label: 'Usuário',
                        // //   textInput: TextInputType.text,
                        // // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        TextFormLoginWidget(
                          controller: _passwordController,
                          icon: const Icon(
                            Icons.vpn_key_rounded,
                            color: Colors.white,
                          ),
                          cor: Colors.white,
                          label: 'Senha',
                          isObscure: true,
                          textInput: TextInputType.text,
                          showButtom: true,
                          onChangeController: _controller.setSenha,
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // TextFormLoginWidget(
                        //   icon: const Icon(
                        //     Icons.vpn_key_rounded,
                        //     color: Colors.white,
                        //   ),
                        //   cor: Colors.white,
                        //   label: 'Senha',
                        //   isObscure: true,
                        //   textInput: TextInputType.text,
                        //   showButtom: true,
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        FloatingActionButton.extended(
                          extendedPadding: const EdgeInsets.all(20.0),
                          onPressed: () {
                            CircularProgressIndicator(
                              value: _progressController.value,
                              semanticsLabel: 'Linear progress indicator',
                            );
                            _cadastrar();
                            // (_isLoading) ? CircularProgressIndicator() : _cadastrar();
                          },
                          label: const Text('Cadastrar'),
                          backgroundColor: Colors.red.shade600,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      CadastrarService().cadastrar(
        _nameController.text,
        _mailController.text,
        _passwordController.text,
      );
    } else {
      print("invalido");
    }
  }

  // Future<void> _cadastrar() async {
  // Salvando o usuario aqui
  //   await CircularProgressIndicator();
  //   UserLoginModel newUser = UserLoginModel(
  //       keepOn: true,
  //       name: _nameController.text,
  //       email: _mailController.text,
  //       senha: _passwordController.text);

  //   _saveUser(newUser);
  //   // _saveUser(newUser);
  // }

  // _saveUser(UserLoginModel user) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   http.post(url, body: json.encode(user.toJson())).then(
  //     (value) {
  //       setState(() {
  //         this._isLoading = false;
  //       });

  //       Navigator.pop(context);
  //       final snackBar = SnackBar(
  //         content: const Text('Cadastro salvo com sucesso.'),
  //         action: SnackBarAction(
  //           label: "Dispensar",
  //           onPressed: () {
  //             ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //           },
  //         ),
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     },
  //   );

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setString(
  //   PreferencesKeys.activeUser,
  //   json.encode(user.toJson()),
  // );
  // }
}
