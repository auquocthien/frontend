import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/ui/auth/auth_manager.dart';
import 'package:frontend/ui/auth/login.dart';
import 'package:frontend/ui/home.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;
  Future getAuthToken() async {
    isLogin = await context.read<AuthManager>().isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: FutureBuilder(
        future: getAuthToken(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoginScreen();
          } else {
            return const Home();
          }
        },
      ),
    ));
  }
}
