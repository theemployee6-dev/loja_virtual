import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user_manager.dart';
import 'screens/base/base_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => UserManager(),
      child: MaterialApp(
        title: 'Loja do Daniel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BaseScreen(),
      ),
    );
  }
}
