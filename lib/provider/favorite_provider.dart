import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _films = [];
  List<String> get films => _films;

  void toggleFavorite(String film) {
    final filmExist = _films.contains(film);
    if (filmExist) {
      _films.remove(film);
    } else {
      _films.add(film);
    }
    notifyListeners();
  }

  bool filmExist(String film) {
    final filmExist = _films.contains(film);
    return filmExist;
  }

  void cleanFavorite() {
    _films = [];
    notifyListeners();
  }
}
