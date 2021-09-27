import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'models/product.dart';
import 'models/product_manager.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/product/product_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

import 'models/user_manager.dart';
import 'screens/base/base_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) => cartManager..updateUser(userManager),
        ),
      ],
      child: MaterialApp(
        title: 'Loja do Willians',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            color: const Color.fromARGB(255, 4, 125, 141),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (setting) {
          switch (setting.name) {
            case '/login':
              return MaterialPageRoute(
                builder: (_) => LoginScreen(),
              );
            case '/signup':
              return MaterialPageRoute(
                builder: (_) => SignUpScreen(),
              );
            case '/cart':
              return MaterialPageRoute(
                builder: (_) => CartScreen(),
              );
            case '/product':
              return MaterialPageRoute(
                builder: (_) => ProductScreen(setting.arguments as Product),
              );
            case '/base':
            default:
              return MaterialPageRoute(
                builder: (_) => BaseScreen(),
              );
          }
        },
      ),
    );
  }
}
