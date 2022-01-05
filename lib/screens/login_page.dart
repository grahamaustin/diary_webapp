import 'package:diary_webapp/constants/constants.dart';
import 'package:diary_webapp/widgets/create_account_form.dart';
import 'package:diary_webapp/widgets/login_form.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();

  final GlobalKey<FormState>? _globalKey = GlobalKey<FormState>();
  bool isCreatedAccountClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTealColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                      child: SvgPicture.asset(
                        'assets/images/BOL_Primary_Logo_K_Teal_RGB.svg',
                        color: Colors.white,
                        semanticsLabel: 'Bolesworth Logo',
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 300,
                      height: isCreatedAccountClicked ? 350 : 280,
                      child: isCreatedAccountClicked
                          ? CreateAccountForm(
                              formKey: _globalKey,
                              emailTextController: _emailTextController,
                              passwordTextController: _passwordTextController)
                          : LoginForm(
                              formKey: _globalKey,
                              emailTextController: _emailTextController,
                              passwordTextController: _passwordTextController),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (!isCreatedAccountClicked) {
                            isCreatedAccountClicked = true;
                          } else {
                            isCreatedAccountClicked = false;
                          }
                        });
                      },
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.w300,
                          ),
                          children: [
                            TextSpan(
                                text: isCreatedAccountClicked
                                    ? 'Already have a Bolesworth account? '
                                    : 'Don\'t have an account? '),
                            TextSpan(
                              text: isCreatedAccountClicked
                                  ? 'Sign In'
                                  : 'Create Account',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
