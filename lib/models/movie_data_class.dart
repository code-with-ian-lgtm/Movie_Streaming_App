// ignore_for_file: constant_identifier_names

class Movie {
  final String movieName; // Movie title
  final String posterUrl; // URL to the movie poster
  final String director;  // Director's name
  final String description; // Brief movie description or synopsis
  final List<String> cast; // List of main actors/actresses
  final MovieCategory category; // Movie category/genre
  final double rating; // IMDb or user rating
  final DateTime releaseDate; // Release date of the movie
  final int duration; // Duration of the movie in minutes
  final String trailerUrl; // URL to the movie trailer
  final String language; // Language of the movie
  final String country; // Country where the movie was produced
  final bool isFavorite; // Whether the movie is marked as a favorite by the user

  Movie({
    required this.movieName,
    required this.posterUrl,
    required this.director,
    required this.description,
    required this.cast,
    required this.category,
    required this.rating,
    required this.releaseDate,
    required this.duration,
    required this.trailerUrl,
    required this.language,
    required this.country,
    this.isFavorite = false,
  });
}

enum MovieCategory {
  Action,
  Thriller,
  Horror,
  Comedy,
  Drama,
  SciFi,
  Fantasy,
  Animation,
  Documentary,
  Romance,
}

