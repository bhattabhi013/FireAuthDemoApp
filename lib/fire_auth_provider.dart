import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;

  Stream<User> get authState => _fireAuth.authStateChanges() as Stream<User>;
  serviceResponse res = serviceResponse();
  Future<serviceResponse> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final response = await _fireAuth.signInWithEmailAndPassword(
          email: email, password: password);
      res.status = true;
      res.msg = response as String;
      return res;
    } on FirebaseAuthException catch (e) {
      res.msg = e.message as String;
      res.status = false;
      return res;
    }
  }

  Future<serviceResponse> logOut() async {
    try {
      final response = await _fireAuth.signOut();
      res.status = true;
      res.msg = response as String;
      return res;
    } on FirebaseAuthException catch (e) {
      res.msg = e.message as String;
      res.status = false;
      return res;
    }
  }

  Future<serviceResponse> signUpEmail(
      {required String email, required String password}) async {
    try {
      final response = await _fireAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      res.status = true;
      res.msg = response as String;
      return res;
    } on FirebaseAuthException catch (e) {
      res.msg = e.message as String;
      res.status = false;
      return res;
    }
  }
}

class serviceResponse {
  late String msg;
  late bool status;
}
