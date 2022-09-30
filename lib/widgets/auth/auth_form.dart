import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stranger_chat/widgets/pickers/user_image_picker.dart';

class AuthFromWidget extends StatefulWidget {
  const AuthFromWidget(this.submitFN, this._isLoading, {super.key});

  final void Function(String email, String password, String userName,
      File? file, bool isLogin) submitFN;
  final bool _isLoading;

  @override
  State<AuthFromWidget> createState() => _AuthFromWidgetState();
}

class _AuthFromWidgetState extends State<AuthFromWidget> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File? _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Uplaod A Image'),
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFN(
        _userEmail.trim(),
        _userPassword,
        _userName.trim(),
        _userImageFile,
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        elevation: 10,
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  if (_isLogin)
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://thumbs.dreamstime.com/z/anonymous-user-icon-person-business-suit-question-mark-internet-security-concept-vector-illustration-88848107.jpg'),
                      backgroundColor: Colors.black,
                    ),
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please Enter a valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('userName'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Please Enter a valid user name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value!;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Chat Name',
                      ),
                    ),
                  TextFormField(
                    key: const ValueKey('passWord'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget._isLoading) const CircularProgressIndicator(),
                  if (!widget._isLoading)
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Sign Up'),
                    ),
                  if (!widget._isLoading)
                    TextButton(
                      child: Text(_isLogin
                          ? 'Create New Account'
                          : 'I aleady have an account'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
