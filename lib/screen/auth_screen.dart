// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = 'AuthScreen';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Colors.blueAccent,
        ),
        Container(
          height: deviceSize.height,
          width: deviceSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  child: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text('MyShop'),
              )),
              Flexible(
                flex: deviceSize.height > 600 ? 2 : 1,
                child: AuthCard(),
              ),
            ],
          ),
        )
      ],
    ));
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8,
      child: Container(
        padding: EdgeInsets.all(10),
        height: 300,
        width: deviceSize.width * 0.75,
        color: Colors.white,
        child: Form(
          child: Column(
            children: [TextFormField(), TextFormField()],
          ),
        ),
      ),
    );
  }
}
