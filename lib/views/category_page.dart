// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fluttix/my_drawer.dart';

class CategoryPage extends StatelessWidget {
  final Map category;
  const CategoryPage(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category['name']
        ),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
    );
  }
}