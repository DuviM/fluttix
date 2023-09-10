// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttix/my_drawer.dart';
import 'package:http/http.dart' as http;

class ListActorPAge extends StatefulWidget {
  const ListActorPAge({super.key});

  @override
  State<ListActorPAge> createState() => _ListActorPAgeState();
}

class _ListActorPAgeState extends State<ListActorPAge> {
  List<dynamic> actors = [];

  Future<List<dynamic>> fetchActors() async {
    final response = await http.get(Uri.parse('https://api.vueflix.boxydev.com/actors'));

    return response.statusCode == 200
      ?jsonDecode(response.body)
      : throw Exception('fail');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ACTORS'),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: FutureBuilder(
        future: fetchActors(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          actors = snapshot.data as List<dynamic>;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 400,
            ),
            itemCount: actors.length,
            itemBuilder: (context, index) {
              dynamic actor = actors[index];
              return Card(
                elevation: 0,
                color: Colors.transparent,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: actor['profile_path'] == null ?
                      Image.asset(
                        'images/nopic.jpg',
                        width: 175, height: 300,
                        fit: BoxFit.cover,
                      ):
                      Image.network(
                        actor['profile_path'],
                        width: 175, height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        actor['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        actor['birthday'] == null ?
                        Text(
                          'N/C',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ):
                        Text(
                          actor['birthday'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
          );
        }
      ),
    );
  }
}