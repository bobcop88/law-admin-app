import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adminapp/home_page.dart';



class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({ Key? key }) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {

  bool isEmailVerified = false;
  bool canResendEmailVerification = false;
 
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified){
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }

    if(isEmailVerified){
      timer?.cancel();
    }
  }

  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {

    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
  }

  Future sendVerificationEmail() async {

    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification(); 
      setState(() {
        canResendEmailVerification = false;
      });
        await Future.delayed(Duration(seconds: 10));
        setState(() {
          canResendEmailVerification = true;
        });
    }on FirebaseAuthException catch(e){
      final snackBar = SnackBar(
        content: Text(e.message.toString()),
        );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
    ? HomePage()
    : Scaffold(
      appBar: AppBar(
        title: Text('Verify Email address'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text('The verification email has been sent to your email address')
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              ElevatedButton(
                child: Text('Resend email verification'),
                onPressed: () {canResendEmailVerification ? sendVerificationEmail() : null;}
              ),
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            children: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {FirebaseAuth.instance.signOut();},
              ),
            ],
          ),
        ],
      ),
    );
}