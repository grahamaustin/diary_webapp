import 'package:diary_webapp/constants/constants.dart';

import 'package:diary_webapp/screens/main_page.dart';
import 'package:diary_webapp/services/service.dart';
import 'package:diary_webapp/widgets/input_decorator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({
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
          const Text(
            'Please enter a valid email and password that is at least 6 characters.',
            style: TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
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
              child: const Text(
                'Forgot password',
                style: TextStyle(
                  color: kWhiteColor,
                  fontWeight: FontWeight.w300,
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
                  String email = _emailTextController.text;
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: _passwordTextController.text,
                  )
                      .then((value) {
                    if (value.user != null) {
                      String uid = value.user!.uid;
                      String emailAddress = value.user!.email.toString();
                      String displayName =
                          value.user!.email.toString().split('@')[0];
                      DiaryService()
                          .createUser(displayName, emailAddress, context, uid)
                          .then((value) {
                        DiaryService()
                            .loginUser(
                          email,
                          _passwordTextController.text,
                        )
                            .then((value) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ),
                          );
                        });
                      });
                    }
                  });
                }
              },
              child: Text('Create Account'.toUpperCase()),
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  // padding: const EdgeInsets.symmetric(vertical: 14),
                  primary: kTealColor,
                  backgroundColor: kWhiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
