// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_scratch/provider/auth.dart';

enum AuthMode { SignUp, SingIn }

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
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 90),
                decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  'MyShop',
                  style: TextStyle(fontSize: 50),
                ),
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
  final GlobalKey<FormState> _fromKey = GlobalKey();
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.SingIn;
  bool isLoading = false;
  final Map<String, dynamic> _authData = {
    "email": '',
    "password": '',
  };

  Future<void> _saveFrom() async {
    _fromKey.currentState!.validate();
    _fromKey.currentState!.save();
    try {
      if (_authMode == AuthMode.SignUp) {
        setState(() {
          isLoading = true;
        });
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email'], _authData['password']);
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = true;
        });
        await Provider.of<Auth>(context, listen: false)
            .signIn(_authData['email'], _authData['password']);
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {}
  }

  void _switchMode() {
    if (_authMode == AuthMode.SingIn) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.SingIn;
      });
    }
  }

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
        height: _authMode == AuthMode.SingIn ? 260 : 320,
        width: deviceSize.width * 0.75,
        color: Colors.white,
        child: Form(
          key: _fromKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  _authData['email'] = value;
                },
                decoration: InputDecoration(label: Text('Email')),
                controller: _passwordController,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  _authData['password'] = value;
                },
                decoration: InputDecoration(label: Text('Password')),
              ),
              if (_authMode == AuthMode.SignUp)
                TextFormField(
                  validator: (value) {
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                  decoration: InputDecoration(label: Text('Password')),
                ),
              SizedBox(
                height: 8,
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: _saveFrom,
                      child: Text(
                          _authMode == AuthMode.SingIn ? 'SignIn' : 'SignUp')),
              TextButton(
                  onPressed: _switchMode,
                  child: Text(_authMode == AuthMode.SingIn
                      ? 'SignUp instead'
                      : 'SignIn instead'))
            ],
          ),
        ),
      ),
    );
  }
}
