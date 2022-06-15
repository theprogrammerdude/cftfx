import 'package:cftfx/methods/auth_methods.dart';
import 'package:cftfx/pages/tabs.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:velocity_x/velocity_x.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthMethods _authMethods = AuthMethods();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  bool isPasswordVisible = false;

  login() {
    _authMethods
        .login(_usernameController.text, _passwordController.text)
        .then((value) {
      // print(value.user!.uid);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Tabs(),
          ),
          (route) => false);
    }).catchError((err) {
      // print(err);
      _btnController.reset();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: err.toString().split('] ')[1].text.white.make(),
          backgroundColor: Vx.red600,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                const SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  controller: _usernameController,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: isPasswordVisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  ),
                  controller: _passwordController,
                  obscureText: isPasswordVisible ? false : true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 100,
                ),
                RoundedLoadingButton(
                  controller: _btnController,
                  onPressed: () => login(),
                  child: 'Log in'.text.size(18).make(),
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).primaryColor,
                ).pOnly(bottom: 10),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: 'Go Back'.text.size(18).make(),
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ).wPCT(context: context, widthPCT: 100).h(45)
              ],
            ).p12(),
          ),
        ),
      ),
    );
  }
}
