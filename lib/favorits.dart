import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/provider/favorite_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    final films = provider.films;

    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/starwars.png',
                  height: 100,
                  width: 100,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: films.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final film = films[index];

                return Container(
                  color: Colors.black,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(film, style: TextStyle(color: Colors.white)),
                        GestureDetector(
                          onTap: () {
                            provider.toggleFavorite(film);
                          },
                          child: Icon(
                            provider.filmExist(film)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
