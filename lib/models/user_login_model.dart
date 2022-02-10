class UserLoginModel {
  String? name;
  String? email;
  String? senha;
  bool? keepOn;

  UserLoginModel({this.name, this.email, this.senha, this.keepOn});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    senha = json['senha'];
    keepOn = json['keepOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['senha'] = this.senha;
    data['keepOn'] = this.keepOn;
    return data;
  }

  String toString() {
    return "Name: " + name! + "\nEmail: " + email! + "\nSenha: " + senha!;
  }
}
