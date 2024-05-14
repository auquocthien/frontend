import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/ui/auth/auth_manager.dart';
import 'package:frontend/ui/auth/auth_screen.dart';
import 'package:frontend/ui/cart/cart_screen.dart';
import 'package:frontend/ui/product/product_screen.dart';
import 'package:frontend/ui/subordinates/subordinate_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    String name = context.read<AuthManager>().fullName;
    double revenue = context.read<AuthManager>().perRevenue;
    double subRevenue = context.read<AuthManager>().subRevenue;
    int userId = context.read<AuthManager>().userId;
    return SafeArea(
      child: Drawer(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: Container(
          padding: const EdgeInsets.only(top: 50),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AuthScreen.routeName, arguments: userId);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  margin: EdgeInsets.only(bottom: 30),
                  height: 115,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          'Welcome back',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            child: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://i.pinimg.com/564x/20/1e/14/201e14454ff5ff96bf76913580e9d48c.jpg'),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              width: MediaQuery.of(context).size.width / 2,
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Revenue: $revenue',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'SubRevenue: $subRevenue',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text('Product',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.of(context).pushNamed(ProductScreen.routeName);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('Cart',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Subordinates',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.of(context).pushNamed(SubordinateScreen.routeName,
                      arguments: userId);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Logout',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                onTap: () {},
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
