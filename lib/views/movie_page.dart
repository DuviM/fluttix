// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttix/my_drawer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class MoviePage extends StatelessWidget {
  final Map movie;
  const MoviePage(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie['title'].toUpperCase(),
        ),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Stack( 
        children: [
          Image.network(
            movie['backdrop_path'],
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromRGBO(255, 255, 255, 0.5),
            colorBlendMode: BlendMode.modulate
          ),
          Positioned.fill(
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 15 , 15, 0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              movie['poster_path'],
                              width: 150, height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 200,
                              margin: EdgeInsets.only(left: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        movie['title'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '(${DateTime.parse(movie['release_date']).year.toString()})',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w200
                                        ),
                                      ),
                                      Text(
                                        movie['genre']['name'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),                                        
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '"${movie['tagline']}"',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic
                                        ),
                                      ),
                                    ],
                                  ),                            
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RatingBarIndicator(
                                      rating: movie['vote_average'] / 2,
                                      itemCount: 5,
                                      itemSize: 15.0,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        ),
                                      ),                                    
                                      const SizedBox(width: 30,),
                                      Text(                          
                                        movie['vote_average'].toStringAsFixed(1) + '/10',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () {
                                          showCupertinoModalPopup(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: 200,
                                                color: Colors.black,
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(movie['youtube'])
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          );
                                        },
                                        child: Text(
                                          'Watch trailer',
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),                                  
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Sypnosis :',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        movie['overview'],
                        style: const TextStyle(color: Colors.white),
                      ),                      
                      GridView.builder(                            shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 200,
                        ),
                        itemCount: movie['actorsId'].length,
                        itemBuilder: (context, index) {
                          dynamic actor = movie['actors'][index];
                          return Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: actor['profile_path'] == null ?
                                  Image.asset(
                                    'images/nopic.jpg',
                                    width: 75, height: 100,
                                    fit: BoxFit.cover,
                                  ):
                                  Image.network(
                                    actor['profile_path'],
                                    width: 75, height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        actor['name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'as',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w100
                                        ),
                                      ),
                                      Text(
                                        actor['character'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
