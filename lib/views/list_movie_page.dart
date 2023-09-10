// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttix/my_drawer.dart';
import 'package:fluttix/views/movie_page.dart';
import 'package:http/http.dart' as http;

class ListMoviePage extends StatefulWidget {
  const ListMoviePage({super.key});

  @override
  State<ListMoviePage> createState() => _ListMoviePageState();
}

class _ListMoviePageState extends State<ListMoviePage> {
  List<dynamic> movies = [];

  // await Future.delayed(duration(seconds: 2));
  
  Future<List<dynamic>> fetchMovies() async {
    final response = await http.get(Uri.parse('https://api.vueflix.boxydev.com/movies?_expand=genre&_expand=actors'));

    return response.statusCode == 200
      ? jsonDecode(response.body)
      : throw Exception('fail');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FLUMS'),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: FutureBuilder(
        future: fetchMovies(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          movies = snapshot.data as List<dynamic>;
          
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 445
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              dynamic movie = movies[index];

              return Card(
                elevation: 0,
                color: Colors.transparent,            
                child: Container(
                  height: 445,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          movie['poster_path'],
                          width: 175, height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          movie['title'], textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateTime.parse(movie['release_date']).year.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 40,),
                          Icon(Icons.star, size: 15, color: Colors.yellow),
                          SizedBox(width: 4,),
                          Text(                          
                            movie['vote_average'].toStringAsFixed(1) + '/10',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: ElevatedButton(
                              onPressed: () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => MoviePage(movies[index])),                          
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                              ), 
                              child: Text('See movie'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          );
        }
      )
    );
  }
}