import 'package:flutter/material.dart';
import 'package:frontend/ui/auth/auth_info.dart';
import 'package:frontend/ui/shared/app_drawer.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  final String userId;
  const AuthScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Product',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 83, 86, 255),
      ),
      drawer: const AppDrawer(),
      body: AuthInfo(
        userId: userId,
      ),
    );
  }
}
