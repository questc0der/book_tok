import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDao extends ChangeNotifier {
  String errorMsg = 'An error has occurred.';
  final auth = FirebaseAuth.instance;

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  String? userId() {
    return auth.currentUser?.uid;
  }

  String? email() {
    return auth.currentUser?.email;
  }

  Future<String?> signup(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      if (email.isEmpty) {
        errorMsg = 'Email is blank.';
      } else if (password.isEmpty) {
        errorMsg = 'Password is blank.';
      } else if (e.code == 'weak-password') {
        errorMsg = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMsg = 'The account already exists for that email.';
      }
      return errorMsg;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      if (email.isEmpty) {
        errorMsg = 'Email is blank.';
      } else if (password.isEmpty) {
        errorMsg = 'Password is blank.';
      } else if (e.code == 'invalid-email') {
        errorMsg = 'Invalid email.';
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        errorMsg = 'Invalid credentials.';
      } else if (e.code == 'user-not-found') {
        errorMsg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMsg = 'Wrong password provided for that user.';
      }
      return errorMsg;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  void logout() async {
    await auth.signOut();
    notifyListeners();
  }
}
