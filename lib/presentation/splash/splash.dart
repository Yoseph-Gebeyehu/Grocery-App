import 'package:flutter/material.dart';

import '../Auth/View/signin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const splashScreen = '/';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.pushReplacementNamed(context, SigninPage.signIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFFEC54B),
        body: Container(
          margin: const EdgeInsets.only(bottom: 100),
          alignment: Alignment.bottomCenter,
          child: Image.asset('assets/images/splash.png'),
        ),
      ),
    );
  }
}
