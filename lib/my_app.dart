import 'package:flutter/material.dart';
import 'package:fluttix/views/home_page.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluttix',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: const Color.fromRGBO(120, 120, 120, 1)
        // ),
        brightness: Brightness.dark
      ),
      home: const HomePage()
    );
  }
}