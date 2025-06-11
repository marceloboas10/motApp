import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;

  Future<String?> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoading = false;
      notifyListeners();
      return result.user?.uid;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      if (e.code == 'user-not-found') {
        return 'ERRO: Usuário não encontrado';
      } else if (e.code == 'wrong-password') {
        return 'ERRO: Senha incorreta';
      } else if (e.code == 'invalid-email') {
        return 'ERRO: E-mail inválido';
      } else {
        return 'ERRO: ${e.message}';
      }
    }
  }
}
