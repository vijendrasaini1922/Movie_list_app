import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.movie});

  final Movie movie;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Image
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(
                movie.images[movie.images.length - 1],
                fit: BoxFit.cover,
              ),
            ),

            // Image Carousel
            // Image Carousel with Dots
            const SizedBox(height: 12.0),
            SizedBox(
              height: 160,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: movie.images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              movie.images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: movie.images.length,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 6,
                      dotColor: Colors.grey.shade400,
                      activeDotColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Movie Info
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Year
                  Text(
                    '${movie.title} (${movie.year})',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  // Rating, Runtime, Genre
                  Row(
                    children: [
                      _infoChip(context, movie.rated),
                      const SizedBox(width: 8.0),
                      _infoChip(context, movie.runtime),
                      const SizedBox(width: 8.0),
                      _infoChip(context, movie.genre),
                    ],
                  ),
                  const SizedBox(height: 16.0),

                  // Plot
                  Text(
                    movie.plot,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16.0),

                  // Metadata (Director, Writer, Actors, Awards)
                  _infoRow("Director:", movie.director),
                  _infoRow("Writer:", movie.writer),
                  _infoRow("Actors:", movie.actors),
                  _infoRow("Language:", movie.language),
                  _infoRow("Country:", movie.country),
                  _infoRow("Awards:", movie.awards),
                  _infoRow("IMDb Rating:", movie.imdbRating),
                  _infoRow("Metascore:", movie.metascore),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(BuildContext context, String label) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.white)),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: '$title ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
