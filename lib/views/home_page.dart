import 'package:flutter/material.dart';
import 'package:fluttix/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ACCEUIL'),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
    );
  }
}