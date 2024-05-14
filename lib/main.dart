import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/ui/auth/auth_manager.dart';
import 'package:frontend/ui/auth/auth_screen.dart';
import 'package:frontend/ui/auth/login.dart';
import 'package:frontend/ui/cart/cart_manager.dart';
import 'package:frontend/ui/cart/cart_screen.dart';
import 'package:frontend/ui/home.dart';
import 'package:frontend/ui/product/product_detail.dart';
import 'package:frontend/ui/product/product_manager.dart';
import 'package:frontend/ui/product/product_screen.dart';
import 'package:frontend/ui/splash_screen.dart';
import 'package:frontend/ui/subordinates/subordinate_screen.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthManager()),
        ChangeNotifierProvider(create: (ctx) => ProductManager()),
        ChangeNotifierProvider(create: (ctx) => CartManager()),
      ],
      child: Consumer<AuthManager>(
        builder:
            (BuildContext context, AuthManager authManager, Widget? child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: authManager.logined ? const Home() : const LoginScreen(),
            // home: const SplashScreen(),
            routes: {
              ProductScreen.routeName: (ctx) => const ProductScreen(),
              CartScreen.routeName: (ctx) => const CartScreen(),
              // SubordinateScreen.routeName: (ctx) => SubordinateScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == ProductDetails.routeName) {
                final productId = settings.arguments!.toString();

                return MaterialPageRoute(builder: (ctx) {
                  return ProductDetails(productId: productId);
                });
              }

              if (settings.name == AuthScreen.routeName) {
                final userId = settings.arguments!.toString();

                return MaterialPageRoute(builder: (ctx) {
                  return AuthScreen(userId: userId);
                });
              }

              if (settings.name == SubordinateScreen.routeName) {
                final userId = settings.arguments!.toString();

                return MaterialPageRoute(builder: (ctx) {
                  return SubordinateScreen(userId: userId);
                });
              }
            },
          );
        },
      ),
    );
  }
}
