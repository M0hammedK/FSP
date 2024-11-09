import 'package:flutter/material.dart';
import 'package:untitled1/sign_up.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final List<Map<String, dynamic>> todaysMovies = [
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

  final List<Map<String, dynamic>> upcomingMovies = [
    {
      'title': 'Movie 4',
      'posterUrl': 'images/Talktome.jpg', // Replace with actual asset path
      'genre': 'Genre 4',
      'rating': 7.2,
    },
    {
      'title': 'Movie 5',
      'posterUrl': 'images/Oppenhiemer.jpg', // Replace with actual asset path
      'genre': 'Genre 5',
      'rating': 8.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "images/backgroundblue.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Profile Options',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  // Navigate to Profile
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(
                            // username: '',
                            // email: '',
                          ),
                        ),
                      );
                    },
                  ),
                  // Sign Up Option
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text('Create New Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const sign_up(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text(
                'CinemaTech',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              backgroundColor: Colors.black.withOpacity(0.7),
              elevation: 10,
            ),
            body: Container(
              child: ListView(
                children: [
                  _buildSectionHeader('Today\'s Movies'),
                  _buildMovieCarousel(todaysMovies),
                  _buildSectionHeader('Upcoming Movies'),
                  _buildMovieCarousel(upcomingMovies),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Updated color
        ),
      ),
    );
  }

  Widget _buildMovieCarousel(List<Map<String, dynamic>> movies) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCard(
            title: movie['title'],
            posterUrl: movie['posterUrl'],
            genre: movie['genre'],
            rating: movie['rating'],
          );
        },
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.title,
    required this.posterUrl,
    required this.genre,
    required this.rating,
  }) : super(key: key);

  final String title;
  final String posterUrl;
  final String genre;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180, // Adjusted width for iPhone 12 Pro
      child: Card(
        color: Colors.grey[300], // Set the background color
        child: Column(
          children: [
            Image.asset(
              posterUrl,
              height: 200, // Adjust the height as needed
              width: 180, // Adjusted width for iPhone 12 Pro
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('$genre | Rating: $rating',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
