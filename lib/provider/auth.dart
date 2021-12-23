// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
  DateTime? _expiryDate;
  Timer? authTimer;
  bool? get isAuth {
    if (token != null) {
      return true;
    }
    return false;
  }

  String? get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String specialKey) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$specialKey?key=AIzaSyDTCCNk_77P-B34_oO5orRhsUTbNx-iP28';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      print(response.body);
      final responseData = json.decode(response.body);
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      autoLogout();
      notifyListeners();
      final internalStorage = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String(),
      });
      internalStorage.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefData = await SharedPreferences.getInstance();
    if (!prefData.containsKey('userData')) {
      return false;
    }
    final loginData =
        json.decode(prefData.getString('userData')!) as Map<String, dynamic>;
    final expiaryTime = DateTime.parse(loginData['expiryDate']);
    if (expiaryTime.isBefore(DateTime.now())) {
      return false;
    }

    _token = loginData['token'];
    _userId = loginData['userId'];
    _expiryDate = expiaryTime;
    autoLogout();
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (authTimer != null) {
      authTimer!.cancel();
      authTimer = null;
    }
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  void autoLogout() {
    if (authTimer != null) {
      authTimer!.cancel();
    }
    final expiryTimeInSec = _expiryDate!.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: expiryTimeInSec), logout);
  }
}
