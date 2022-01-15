import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'alert.dart';
import 'fire_auth_provider.dart';
import 'google_auth_provider.dart';
import 'sign_up.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final googleAuth = Provider.of<GoogleSignInProvider>(context);

    print('user $user');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Firebase Application',
          softWrap: true,
          style: TextStyle(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: const Text("Hello There! Logged In"),
          ),
          const SizedBox(height: 10),
          Center(
            child: FlatButton(
              onPressed: () {
                signOut(auth, context, googleAuth);
                Navigator.of(context).pushReplacementNamed(SignUp.routeName);
              },
              textColor: Colors.purple,
              child: const Text('Sign out'),
            ),
          )
        ],
      ),
    );
  }

  void signOut(
      AuthService auth, BuildContext context, GoogleSignInProvider gAuth) {
    if (user!.providerData[0].providerId == "google.com") {
      // signed via google
      gAuth.handleSignOut();
    }
    auth.logOut().then((value) {
      if (value.status) {
        Navigator.of(context).pushReplacementNamed(SignUp.routeName);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertClass(title: "Auth Failed", message: value.msg);
          },
        );
      }
    });
  }
}
