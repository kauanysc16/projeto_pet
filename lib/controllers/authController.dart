import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  static final List<User> _users = [];

  // Cadastro de um novo usuário
  static void registerUser(User user) {
    _users.add(user);
  }

  // Verifica se o CPF e a senha correspondem
  static bool login(String cpf, String password) {
    for (var user in _users) {
      if (user.cpf == cpf && user.password == password) {
        return true;
      }
    }
    return false;
  }

  // Retorna os dados do usuário com base no CPF
  static User? getUserByCPF(String cpf) {
    try {
      return _users.firstWhere((user) => user.cpf == cpf);
    } catch (e) {
      // Caso não encontre nenhum usuário com o CPF fornecido, retorna null
      return null;
    }
  }
}

class User {
  final String cpf;
  final String password;

  User({
    required this.cpf,
    required this.password,
  });
}
