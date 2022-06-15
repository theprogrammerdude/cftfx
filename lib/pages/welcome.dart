import 'package:cftfx/pages/login.dart';
import 'package:cftfx/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  navigate(BuildContext context, route) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset(
                  'assets/logo.png',
                  width: 100,
                  height: 100,
                ),
                'crypto future trade \n ( fx )'
                    .text
                    .bold
                    .size(32)
                    .align(TextAlign.center)
                    .make(),
                const SizedBox(height: 20),
                'Trade anytime, anywhere'.text.bold.size(20).make(),
                const SizedBox(
                  height: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => navigate(context, const Signup()),
                      child: 'Sign Up'.text.bold.size(18).make(),
                    ).wPCT(context: context, widthPCT: 45).h(50),
                    ElevatedButton(
                      onPressed: () => navigate(context, const Login()),
                      child: 'Login'.text.bold.size(18).make(),
                    ).wPCT(context: context, widthPCT: 45).h(50),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                'I confirm that I\'m an adult and and accept the terms of CryptoFutureTrade and the Privacy Policy'
                    .text
                    .gray500
                    .align(TextAlign.center)
                    .make()
                    .pSymmetric(v: 10)
              ],
            ).p12(),
          ),
        ),
      ),
    );
  }
}
