import 'package:flutter/material.dart';
import 'package:wallpapers/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFC2D9EC),
          appBarTheme: const AppBarTheme(centerTitle: true)),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
