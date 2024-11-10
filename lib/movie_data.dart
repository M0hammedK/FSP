class MovieData {
  static final MovieData _instance = MovieData._internal(); // Private static instance

  factory MovieData() => _instance; // Factory constructor

  MovieData._internal(); // Private constructor

  // Shared movie lists
  List<Map<String, dynamic>> todaysMovies = [
    {
      'title': 'Oppenheimer',
      'posterUrl': 'images/Oppenhiemer.jpg',
      'genre': 'Biography, Drama, History',
      'rating': 8.6,
    },
    {
      'title': 'Barbie',
      'posterUrl': 'images/QuietPlace.jpg',
      'genre': 'Adventure, Comedy, Fantasy',
      'rating': 7.6,
    },
    {
      'title': 'Talk to Me',
      'posterUrl': 'images/Talktome.jpg',
      'genre': 'Horror, Mystery, Thriller',
      'rating': 7.4,
    },
  ];

  List<Map<String, dynamic>> upcomingMovies = [
    {
      'title': 'Movie 4',
      'posterUrl': 'images/Talktome.jpg',
      'genre': 'Genre 4',
      'rating': 7.2,
    },
    {
      'title': 'Movie 5',
      'posterUrl': 'images/Oppenhiemer.jpg',
      'genre': 'Genre 5',
      'rating': 8.0,
    },
  ];
}
