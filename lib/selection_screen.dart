import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'home.dart';
import 'sign_up.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: const CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return Home();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error in logging in...'),
            );
          } else {
            return SignUp();
          }
        },
      ),
    );
  }
}
