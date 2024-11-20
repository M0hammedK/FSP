import 'package:flutter/material.dart';
import 'package:untitled1/TicketsPage.dart';
import 'package:untitled1/adminpage.dart';
import 'movie_data.dart';
import 'moviepage.dart';
import 'sign_up.dart';
import 'sign_in.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final MovieData movieData = MovieData(); // Reference the singleton

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "images/backgroundblack.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            drawer: Drawer(
              child: Container(
                color: Colors.black87,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: (sign_up.image != null)
                                ? FileImage(sign_up.image!)
                                : const AssetImage('images/CinemaTech.png')
                                    as ImageProvider,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            (sign_up.username.text.trim() != "")
                                ? sign_up.username.text.trim()
                                : "CinemaTech",
                            style: const TextStyle(
                              color: Colors.tealAccent,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Navigate to Profile
                    (sign_up.username.text == "")
                        ? ListTile(
                            leading: const Icon(Icons.account_circle,
                                color: Colors.white),
                            title: const Text('Sign In',
                                style: TextStyle(color: Colors.white)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const sing_in()),
                              );
                            },
                          )
                        : (sign_up.username.text != "admin")
                            ? ListTile(
                                leading: const Icon(Icons.local_movies_sharp,
                                    color: Colors.white),
                                title: const Text('Your Tickets',
                                    style: TextStyle(color: Colors.white)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const TicketsPage()),
                                  );
                                },
                              )
                            : ListTile(
                                leading: const Icon(Icons.admin_panel_settings,
                                    color: Colors.white),
                                title: const Text('Admin Page',
                                    style: TextStyle(color: Colors.white)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminPage()),
                                  );
                                },
                              ),
                    // Sign Up Option
                    (sign_up.username.text == "")
                        ? ListTile(
                            leading: const Icon(Icons.person_add,
                                color: Colors.white),
                            title: const Text('Sign Up',
                                style: TextStyle(color: Colors.white)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const sign_up()),
                              );
                            },
                          )
                        : (sign_up.username.text != "admin")
                            ? ListTile(
                                leading: const Icon(Icons.logout,
                                    color: Colors.white),
                                title: const Text('Sign Out',
                                    style: TextStyle(color: Colors.white)),
                                onTap: () {
                                  sign_up.username.text = "";
                                  sign_up.image = null;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                  );
                                },
                              )
                            : ListTile(
                                leading: const Icon(Icons.local_movies_sharp,
                                    color: Colors.white),
                                title: const Text('All Tickets',
                                    style: TextStyle(color: Colors.white)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const TicketsPage()),
                                  );
                                },
                              ),
                    (sign_up.username.text == "admin")
                        ? ListTile(
                            leading:
                                const Icon(Icons.logout, color: Colors.white),
                            title: const Text('Sign Out',
                                style: TextStyle(color: Colors.white)),
                            onTap: () {
                              sign_up.username.text = "";
                              sign_up.image = null;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                              );
                            },
                          )
                        : ListTile(),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text(
                'CinemaTech',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              backgroundColor: Colors.black.withOpacity(0.8),
              elevation: 10,
              iconTheme: const IconThemeData(
                // Change drawer icon color here
                color: Colors.deepPurple,
              ),
            ),
            body: Container(
              child: ListView(
                children: [
                  _buildSectionHeader('Today\'s Movies'),
                  _buildMovieCarousel(
                      movieData.todaysMovies), // Access singleton's data
                  _buildSectionHeader('Upcoming Movies'),
                  _buildMovieCarousel(
                      movieData.upcomingMovies), // Access singleton's data
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
          return GestureDetector( // Wrap MovieCard with GestureDetector
            onTap: () {
              // Navigate to the desired page here
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => moviepage( // Assuming MovieDetailsPage is your target page
                    title: movie['title'],
                    story: movie['story'],
                    posterUrl: movie['posterUrl'],
                    genre: movie['genre'],
                    rating: movie['rating'],
                  ),
                ),
              );
            },
            child: MovieCard(
              title: movie['title'],
              posterUrl: movie['posterUrl'],
              genre: movie['genre'],
              rating: movie['rating'],
            ),
          );
        },
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String posterUrl;
  final String genre;
  final double rating;

  const MovieCard({
    Key? key,
    required this.title,
    required this.posterUrl,
    required this.genre,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        color: Colors.black.withOpacity(0.5), // Set the background color
        child: Column(
          children: [
            (posterUrl.substring(0, 4) != "http")
                ? Image.asset(
                    posterUrl,
                    height: 200,
                    width: 180,
                    fit: BoxFit.cover,
                  )
                : Image.network(posterUrl,
                    height: 200, width: 180, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '$genre',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        const TextSpan(
                          text: ' | ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextSpan(
                          text: 'Rating: $rating',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
