// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
                              margin: EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie['title'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19
                                    ),
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
                                      // Text(
                                      //   movie['genre'],
                                      //   style: const TextStyle(
                                      //     color: Colors.white,
                                      //   ),                                        
                                      // )
                                    ],
                                  ),
                                  Text(
                                    '"${movie['tagline']}"',
                                    style: const TextStyle(color: Colors.white),
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
                                      const SizedBox(width: 10,),
                                      Text(                          
                                        movie['vote_average'].toStringAsFixed(1) + '/10',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      
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
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Sypnosis',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        movie['overview'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      
              //         GridView.builder(
              //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              //           itemCount: movie['actorsId'].length,
              //           itemBuilder: (context, index) {
              //             dynamic actor = movie['actorId'][index];

              //             return Card(
              //   elevation: 0,
              //   color: Colors.transparent,
              //   child: Column(
              //     children: [
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(10),
              //         child: actor['profile_path'] == null ?
              //         Image.asset(
              //           'images/nopic.jpg',
              //           width: 175, height: 300,
              //           fit: BoxFit.cover,
              //         ):
              //         Image.network(
              //           actor['profile_path'],
              //           width: 175, height: 300,
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //       Container(
              //         margin: EdgeInsets.only(top: 10),
              //         padding: EdgeInsets.symmetric(vertical: 10),
              //         child: Text(
              //           actor['name'],
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           actor['birthday'] == null ?
              //           Text(
              //             'N/C',
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //               color: Colors.white,
              //             ),
              //           ):
              //           Text(
              //             actor['birthday'],
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //               color: Colors.white,
              //             ),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // );
              //           }
              //         )
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
