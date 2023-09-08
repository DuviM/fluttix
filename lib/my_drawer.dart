import 'package:flutter/material.dart';
import 'package:fluttix/views/about_page.dart';
import 'package:fluttix/views/category_page.dart';
import 'package:fluttix/views/list_actors_page.dart';
import 'package:fluttix/views/list_movie_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  List<dynamic> categories = [];

  Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse('https://api.vueflix.boxydev.com/genres'));

    return response.statusCode == 200
      ? jsonDecode(response.body)
      : throw Exception('fail');
  }
  
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w400);  
  static const TextStyle optionStyleTwo =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w200);  

  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(32, 32, 28, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Text(
                      'FLUTTIX',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ],                  
                ),
              ),
              ListTile(
                title: const Text(
                  'Movies',
                  style: optionStyle,
                ),
                // selected: _selectedIndex == 0,
                onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ListMoviePage()),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              ExpansionTile(
                title: const Text(
                  'Categories',
                  style: optionStyle,
                ),
                trailing: Icon(
                   _customTileExpanded
                      ? Icons.arrow_drop_down_circle
                      : Icons.arrow_drop_down,
                ),
                children: [
                  Text('tooto'),
                  FutureBuilder(
                    future: fetchCategories(),
                    builder: (context, snapshot) {
                      
                      if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                      categories = snapshot.data as List<dynamic>;
                      return Column(
                        children: [
                        ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                          dynamic category = categories[index];
                            return ListTile (
                              title: Text(
                                category['name'],
                                style: optionStyleTwo,
                              ),
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => CategoryPage())
                                );
                              }
                              );
                            },                        
                          )
                        ],                  
                      ); 
                    }
                  )
                ],
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    _customTileExpanded = expanded;
                  });
                },
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                title: const Text(
                  'Actors',
                  style: optionStyle,
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ListActorPAge())
                  );
                }
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                title: const Text(
                  'About',
                  style: optionStyle,
                ),
                // selected: _selectedIndex == 2,
                onTap: () {
                  // _onItemTapped(2);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AboutPage())
                  );
                }
              ),
            ],
          ),      
    );
  }
}