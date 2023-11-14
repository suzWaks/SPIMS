import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

final authenticationProvider = ChangeNotifierProvider<AuthProvider>(
  create: (ref) => AuthProvider(),
);

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void login() {
    // Perform authentication logic here
    _isAuthenticated = true;

    // Notify listeners of the change in authentication status
    notifyListeners();
  }

  void logout() {
    // Perform logout logic here
    _isAuthenticated = false;

    // Notify listeners of the change in authentication status
    notifyListeners();
  }
}
