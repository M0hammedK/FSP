class MovieData {
  static final MovieData _instance =
      MovieData._internal(); // Private static instance

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
      'duration': '02:31:23',
      'date': '12/12/2024 22:00',
      'genre': 'Biography, Drama, History',
      'rating': 8.6,
      'price': 5000,
      'category': 'today',
    },
    {
      'title': 'A Quiet Place Part II',
      'story':
          'Following the events at home, the Abbott family now face the terrors of the outside world.'
              ' Forced to venture into the unknown, they realize the creatures that hunt by sound'
              ' are not the only threats lurking beyond the sand path.',
      'posterUrl': 'images/QuietPlace.jpg',
      'duration': '01:35:33',
      'date': '1/11/2024 00:00',
      'genre': 'Adventure, Comedy, Fantasy',
      'rating': 7.6,
      'price': 8000,
      'category': 'today',
    },
    {
      'title': 'Talk to Me',
      'story':
          'When a group of friends discover how to conjure spirits using an embalmed hand,'
              ' they become hooked on the new thrill, until one of them goes too far and unleashes terrifying supernatural forces.',
      'posterUrl': 'images/Talktome.jpg',
      'duration': '02:05:00',
      'date': '01/01/2025 20:00',
      'genre': 'Horror, Mystery, Thriller',
      'rating': 7.4,
      'price': 10000,
      'category': 'today',
    },
  ];

  List<Map<String, dynamic>> upcomingMovies = [
    {
      'title': 'WEREWOLVES',
      'story':
          'Two scientists try to stop a mutation that turns people into werewolves after being touched by a super-moon the year before.',
      'posterUrl': 'images/werewolves.jpg',
      'duration': '',
      'date': '06/12/2024',
      'genre': 'werewolf horror, zombie horror, action, horror, thriller',
      'rating': 0.0,
      'price': 0,
      'category': 'upcoming',
    },
    {
      'title': 'From The Ashes',
      'story':
          "A woman is jailed for her husband's crime, and her only way out is to solve riddles from her mysterious past.",
      'posterUrl': 'images/from_the_ashes.jpg',
      'duration': '',
      'date': '01/12/2024',
      'genre': 'Crime, Drama, Mystery',
      'rating': 0.0,
      'price': 0,
      'category': 'upcoming',
    },
    {
      'title': 'The Elder Ring: The War of the Rohirrim',
      'story':
          'TA sudden attack by Wulf, a clever and ruthless Dunlending lord seeking vengeance for the death of his father,'
              ' forces Helm Hammerhand, the King of Rohan, and his people to make a daring last stand in the ancient stronghold of the Hornburg.',
      'posterUrl': 'images/the_elder_ring.jpg',
      'duration': '',
      'date': '12/12/2024',
      'genre': 'Adventure Epic, Dark Fantasy, Fantasy Epic, Sword & Sorcery, Action, Adventure, Animation, Drama, Fantasy',
      'rating': 0.0,
      'price': 0,
      'category': 'upcoming',
    },
    {
      'title': 'Devil May Cry',
      'story':
          "Follows a professional demon hunter named Dante seeking vengeance for the death of his family.",
      'posterUrl': 'images/devil_may_cry.jpg',
      'duration': '',
      'date': '??/??/2025',
      'genre': 'Anime, Dark Fantasy, Action, Adventure, Fantasy, Mystery',
      'rating': 0.0,
      'price': 0,
      'category': 'upcoming',
    },
  ];

  List<Map<String, dynamic>> Tickets = [];
}
