import 'package:flutter/material.dart';
import 'package:myapp/screens/login_view.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
        fontFamily: 'Arial',
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 255, 150, 13),
        ),
      ),
      home: LoginView(),
    );
  }
}
