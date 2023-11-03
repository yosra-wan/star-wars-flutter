import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:starwars/favorits.dart';
import 'dart:convert';

import 'package:starwars/filmsdetails.dart';
import 'package:starwars/model/item.dart';
import 'package:starwars/provider/favorite_provider.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  late Future<List<Item>> filmsData;

  @override
  void initState() {
    super.initState();
    filmsData = fetchFilms();
  }

  Future<List<Item>> fetchFilms() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/films'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final films = jsonData['results'] as List<dynamic>;
      final itemList = films
          .map((film) => Item(
                producer: film['producer'],
                director: film['director'],
                title: film['title'],
                opening_crawl: film['opening_crawl'],
                release_date: film['release_date'],
              ))
          .toList();

      return itemList;
    } else {
      throw Exception('Failed to load films');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Think-it Star Wars'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.black,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/starwars.png',
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 20),
                  FutureBuilder<List<Item>>(
                    future: filmsData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final films = snapshot.data!;
                        return Text(
                          'Total  ${films.length} Movies',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        );
                      } else {
                        return Text('No data available.');
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: FutureBuilder<List<Item>>(
                future: filmsData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final films = snapshot.data!;
                    return ListView.builder(
                      itemCount: films.length,
                      itemBuilder: (context, index) {
                        final film = films[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    color: Colors.black,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FilmDetailsScreen(
                                                                film: film),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    film.title ?? '',
                                                    style: const TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Consumer<FavoriteProvider>(
                                                  builder: (context,
                                                      favoriteProvider, child) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        favoriteProvider
                                                            .toggleFavorite(
                                                                film.title);
                                                      },
                                                      child: Icon(
                                                        favoriteProvider
                                                                .filmExist(
                                                                    film.title)
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                        color: Colors.red,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Release Date",
                                                  style: const TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  film.release_date ?? '',
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Director",
                                                  style: const TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  film.director ?? '',
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Producer",
                                                  style: const TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  film.producer ?? '',
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                          child: Text(
                                            film.opening_crawl ?? '',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No data available.'));
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              final route =
                  MaterialPageRoute(builder: (context) => FavoriteScreen());
              Navigator.push(context, route);
            },
            label: Text('Favorites')));
  }
}
