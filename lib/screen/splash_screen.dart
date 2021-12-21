// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = 'SplashScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}
