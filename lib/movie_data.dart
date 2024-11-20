class MovieData {
  static final MovieData _instance = MovieData._internal(); // Private static instance

  factory MovieData() => _instance; // Factory constructor

  MovieData._internal(); // Private constructor

  // Shared movie lists
  List<Map<String, dynamic>> todaysMovies = [
    {
      'title': 'Oppenheimer',
      'story': 'A dramatization of the life story of J. Robert Oppenheimer,'
          ' the physicist who had a large hand in the development of the atomic bombs'
          ' that brought an end to World War II.',
      'posterUrl': 'images/Oppenhiemer.jpg',
      'genre': 'Biography, Drama, History',
      'rating': 8.6,
    },
    {
      'title': 'A Quiet Place Part II',
      'story': 'Following the events at home, the Abbott family now face the terrors of the outside world.'
    ' Forced to venture into the unknown, they realize the creatures that hunt by sound'
    ' are not the only threats lurking beyond the sand path.',
      'posterUrl': 'images/QuietPlace.jpg',
      'genre': 'Adventure, Comedy, Fantasy',
      'rating': 7.6,
    },
    {
      'title': 'Talk to Me',
      'story': 'When a group of friends discover how to conjure spirits using an embalmed hand,'
    ' they become hooked on the new thrill, until one of them goes too far and unleashes terrifying supernatural forces.',
      'posterUrl': 'images/Talktome.jpg',
      'genre': 'Horror, Mystery, Thriller',
      'rating': 7.4,
    },
  ];

  List<Map<String, dynamic>> upcomingMovies = [
    {
      'title': 'Talk to Me',
      'story': 'When a group of friends discover how to conjure spirits using an embalmed hand,'
          ' they become hooked on the new thrill, until one of them goes too far and unleashes terrifying supernatural forces.',
      'posterUrl': 'images/Talktome.jpg',
      'genre': 'Genre 4',
      'rating': 7.2,
    },
    {
      'title': 'Oppenheimer',
      'story': 'A dramatization of the life story of J. Robert Oppenheimer,'
          ' the physicist who had a large hand in the development of the atomic bombs'
          ' that brought an end to World War II.',
      'posterUrl': 'images/Oppenhiemer.jpg',
      'genre': 'Genre 5',
      'rating': 8.0,
    },
  ];


  List<Map<String, dynamic>> Tickets= [

    {
      'title':'Default Ticket'
      ,
      'userEmail':'Default Ticket'
    }
  ];
}
