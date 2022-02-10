import 'package:flutter_dotenv/flutter_dotenv.dart';

class Routes {
  // Isso aqui é no firebase configurações> Chave de API da Web
  // E o authService ta na doecumentação firebase Auth Rest
  static const String authService =
      "https://identitytoolkit.googleapis.com/v1/";

  String apiKey = dotenv.get('API_KEY').toString();

  String logar() {
    return authService + "accounts:signInWithPassword?key=" + apiKey;
  }

  String cadastrar() {
    return authService + "accounts:signUp?key=" + apiKey;
  }
}
