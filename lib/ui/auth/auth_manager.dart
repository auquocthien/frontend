import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager with ChangeNotifier {
  User? user;
  bool isLogined = false;

  final AuthService _authService;
  AuthManager() : _authService = AuthService();

  int get managerId {
    return user!.managerId;
  }

  int get userId {
    return user!.userId;
  }

  double get subRevenue {
    return user!.subRevenue;
  }

  double get perRevenue {
    return user!.perRevenue;
  }

  String get fullName {
    return user!.fullName;
  }

  bool get logined {
    return isLogined;
  }

  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      print(token);
      try {
        Map<String, dynamic> tokenPayload = json.decode(token);
        DateTime expireDate = DateTime.parse(tokenPayload['exp']);

        if (expireDate.isAfter(DateTime.now())) {
          isLogined = true;
          return isLogined;
        }
      } catch (e) {
        return false;
        // throw Exception('error while get token $e');
      }
    }
    isLogined = false;
    notifyListeners();
    return isLogined;
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> login(payload) async {
    try {
      if (!isLogined) {
        user = await _authService.login(payload);
        isLogined = true;
        await saveToken(user!.token);
        await isLogin();
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<List<User>> getSubordinate(userId) async {
    List<User> result = [];
    try {
      result = await _authService.getSubordinate(userId);

      if (result.isNotEmpty) {
        return result;
      }
    } catch (e) {
      throw Exception('cannot get suborinate $e');
    }
    return result;
  }
}
