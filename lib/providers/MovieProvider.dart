import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/utils/movie_parser.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> _movieList = [];

  // getter
  List<Movie> get movieList => _movieList;

  Future<void> loadMovies(BuildContext context) async {
    try {
      final jsonString = await DefaultAssetBundle.of(
        context,
      ).loadString('assets/data/movies.json');
      final movies = MovieParser.Parser(jsonString);

      _movieList = movies;
      notifyListeners();
    } catch (e) {
      print("Error : $e");
    }
  }
}
