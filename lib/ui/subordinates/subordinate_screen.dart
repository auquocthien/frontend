import 'package:flutter/material.dart';
import 'package:frontend/ui/product/product_grid.dart';
import 'package:frontend/ui/shared/app_drawer.dart';
import 'package:frontend/ui/subordinates/subordinate_list.dart';

class SubordinateScreen extends StatelessWidget {
  static const routeName = '/subordinate';
  final String userId;
  const SubordinateScreen({super.key, required this.userId});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Subordinate',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 83, 86, 255),
      ),
      drawer: const AppDrawer(),
      body: SubordinateList(
        userId: userId,
      ),
    );
  }
}
