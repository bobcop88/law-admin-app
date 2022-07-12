import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adminapp/main.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({ Key? key }) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reset Password'
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Receive an email to reset your password'
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Email address'
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) => 
                      email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email address'
                      : null
                      ,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Reset Password'
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Future resetPassword() async {

  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => Center(child: CircularProgressIndicator()),
  //   );
    
  //   try {await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());

  //   final snackBar = SnackBar(
  //       content: Text('Reset Password email has been sent'),
  //       );

  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }on FirebaseAuthException catch(e){

  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
  //   }

  //   navigatorKey.currentState!.popUntil((route) => route.isFirst);
  // }
}