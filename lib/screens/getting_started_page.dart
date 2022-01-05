import 'package:diary_webapp/constants/constants.dart';
import 'package:diary_webapp/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GettingStarted extends StatelessWidget {
  const GettingStarted({Key? key}) : super(key: key);

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
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                      child: SvgPicture.asset(
                        'assets/images/BOL_Primary_Logo_K_Teal_RGB.svg',
                        color: Colors.white,
                        semanticsLabel: 'Bolesworth Logo',
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 14),
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: kWhiteColor,
                            ),
                            children: [
                              TextSpan(
                                  text: 'Sign in',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w800)),
                              TextSpan(
                                  text: ' to get started!',
                                  style: TextStyle(fontWeight: FontWeight.w300))
                            ],
                          ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          width: 1,
                          color: kWhiteColor,
                        ),
                        // backgroundColor: Colors.white,
                      ),
                    ),
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
