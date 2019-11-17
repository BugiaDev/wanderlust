import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wanderlust/src/models/user.dart';

class LoginProvider {
  String email;
  String password;

  LoginProvider(this.email, this.password);

  Future<User> authenticate() async {
    try {
      AuthResult authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email, password: password);
      print('LoginProvider: ' + authResult.user.email);
      return new User(authResult.user.uid, authResult.user.email);
    } catch (error) {
      return new User("", "");
    }
  }
}