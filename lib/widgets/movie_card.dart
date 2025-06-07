
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/pages/movie_details.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(movie.title),
        subtitle: Text(movie.director),
        leading: CircleAvatar(child: Text(movie.title[0])),
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: 40,
              bottom: 8,
              right: 8,
              top: 8,
            ),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: "Released: ",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      TextSpan(text: movie.released),
                      TextSpan(
                        text: "\nPlot: ",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      TextSpan(text: movie.plot),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 30, 121, 33),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetails(movie : movie),
                        ),
                      );
                    },
                    child: Text(
                      "Read More ..",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
