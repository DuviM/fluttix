import 'package:flutter/material.dart';
import 'package:fluttix/my_drawer.dart';

class ActorPage extends StatelessWidget {
  const ActorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('this.movieblblb'),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
    );
  }
}