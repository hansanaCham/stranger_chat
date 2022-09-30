import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stranger_chat/screens/auth_scree.dart';
import 'package:stranger_chat/screens/chat_log.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp().whenComplete(() async {
      print('adad');
    });
    return MaterialApp(
      title: 'Stranger Chat',
      theme: ThemeData(
        backgroundColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.black,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const ChatLog();
            }
            return const AuthScreen();
          }),
    );
  }
}
