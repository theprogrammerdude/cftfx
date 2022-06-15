import 'package:cftfx/methods/auth_methods.dart';
import 'package:cftfx/pages/tabs.dart';
import 'package:cftfx/pages/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

final AuthMethods _authMethods = AuthMethods();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CFT (fx)',
      theme: FlexThemeData.light(
        scheme: FlexScheme.shark,
        fontFamily: GoogleFonts.ubuntu().fontFamily,
      ),
      home: _authMethods.currentUser() == null ? const Welcome() : const Tabs(),
    );
  }
}
