import 'package:adminapp/login/login_page.dart';
import 'package:adminapp/login/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({ Key? key }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return isLogin
     ? LoginPage(onClickedSignUp: toggle,)
     : SignUpPage(onClickedSignIn: toggle);
  }

  void toggle() => setState(() {
    isLogin = !isLogin;
  });
}