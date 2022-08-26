import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

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
        title: const Text('Reset Password'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
                width: 500,
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const SizedBox(
                    //   height: 20.0,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -1),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 6.0, left: 50.0, right: 50.0),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Enter your email address and reset your password',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          isDense: true,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          hintText: 'Email address',
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(15, 48, 65, 1),
                                width: 1.0,
                                style: BorderStyle.solid),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                                style: BorderStyle.solid),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                                style: BorderStyle.solid),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                                style: BorderStyle.solid),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        style: const TextStyle(
                            color: Color.fromRGBO(15, 48, 65, 1),
                            fontSize: 14.0),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid email address'
                                : null,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: resetPassword,
                          child: const Text('Reset Password'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future resetPassword() async {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Center(child: CircularProgressIndicator()),
    // );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      final snackBar = const SnackBar(
        content: Text('Reset Password email has been sent'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17.0,
            ),
          ),
          backgroundColor: Colors.black,
        ),
      );
    }
  }
}
