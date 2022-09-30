import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stranger_chat/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  Future<void> _submitAuthForm(String email, String password, String userName,
      File? image, bool isLogin) async {
    final _auth = FirebaseAuth.instance;
    UserCredential autResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        autResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        autResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${autResult.user!.uid}.jpg');

        await ref.putFile(image!).whenComplete(() => null);

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(autResult.user!.uid)
            .set(
          {
            'userName': userName,
            'email': email,
            'url': url,
            'user_id': autResult.user!.uid
          },
        );
      }
    } on PlatformException catch (err) {
      var msg = 'An Error Occured';
      if (err.message != null) {
        msg = err.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: AuthFromWidget(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
