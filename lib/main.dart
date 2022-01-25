import 'package:fire_app/cache_Demo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'fire_auth_provider.dart';
import 'firebase_options.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'google_auth_provider.dart';
import 'home.dart';
import 'selection_screen.dart';
import 'sign_in.dart';
import 'sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

signIn() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: "xy@g.com", password: "Abhi@1234");
    print('usecred ${userCredential}');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

class HomePage extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
      ],
      child: MaterialApp(
        title: 'Firebase Demo',
        home: SelectionScreen(),
        routes: {
          Home.routeName: (ctx) => Home(),
          SignIn.routeName: (ctx) => SignIn(),
          SignUp.routeName: (ctx) => SignUp(),
          CacheDemo.routeName: (ctx) => CacheDemo(),
        },
      ),
    );
  }
}
