import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateUserViewModel extends ChangeNotifier {
  bool isLoading = false;

  Future createAccount(String name, String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(result.user!.uid)
          .set({'nome': name, 'email': email});
      isLoading = false;
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (error) {
      return error;
    }
  }
}
