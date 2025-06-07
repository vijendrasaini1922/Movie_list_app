import 'package:movie_app/models/movie.dart';
import 'dart:convert';

class MovieParser {
  static List<Movie> Parser (String jsonString){
    final List<dynamic> parsedJsonList = json.decode(jsonString);
    return parsedJsonList.map((jsonItem) => Movie.fromJson(jsonItem as Map<String, dynamic>)).toList();
  }
}