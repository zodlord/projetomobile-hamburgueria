import 'dart:async';
import 'package:jacksonsburger/pages/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const String id = 'splash_page';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LoginPage(onTap: () {  },)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Image.asset("lib/images/burger-logo.png",
        height: 300,)));
  }
}