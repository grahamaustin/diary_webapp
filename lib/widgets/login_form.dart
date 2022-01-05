import 'package:diary_webapp/constants/constants.dart';
import 'package:diary_webapp/screens/main_page.dart';
import 'package:diary_webapp/widgets/input_decorator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
    GlobalKey<FormState>? formKey,
  })  : _emailTextController = emailTextController,
        _passwordTextController = passwordTextController,
        _globalKey = formKey,
        super(key: key);

  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;
  final GlobalKey<FormState>? _globalKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            validator: (value) {
              return value!.isEmpty ? 'Please entre an email' : null;
            },
            controller: _emailTextController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: buildInputDecorationOnTeal(
                'Email', 'Enter your Email', Icons.email),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            validator: (value) {
              return value!.isEmpty ? 'Please entre a password' : null;
            },
            obscureText: true,
            controller: _passwordTextController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: buildInputDecorationOnTeal(
                'Password', 'Enter your password', Icons.lock),
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Forgot password',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: kWhiteColor,
                    ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 46,
            width: double.infinity,
            child: TextButton(
              onPressed: () async {
                if (_globalKey!.currentState!.validate()) {
                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text,
                  )
                      .then((value) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ));
                  });
                }
                // try {
                //   UserCredential userCredential = await FirebaseAuth.instance
                //       .signInWithEmailAndPassword(
                //           email: "barry.allen@example.com",
                //           password: "SuperSecretPassword!");
                // } on FirebaseAuthException catch (e) {
                //   if (e.code == 'user-not-found') {
                //     print('No user found for that email.');
                //   } else if (e.code == 'wrong-password') {
                //     print('Wrong password provided for that user.');
                //   }
                // }
              },
              child: Text('Sign In'.toUpperCase()),
              style: TextButton.styleFrom(
                  // padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  primary: kTealColor,
                  backgroundColor: kWhiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
