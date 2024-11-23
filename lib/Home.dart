import 'dart:async';

import 'dart:io';

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
  final MovieData movieData = MovieData();
  String _searchTerm = '';
  Timer? _debounce;
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final filteredTodaysMovies = movieData.todaysMovies.where((movie) {
      final title = movie['title'].toLowerCase();
      final searchTerm = _searchTerm.toLowerCase();
      return title.contains(searchTerm);
    }).toList();

    final filteredUpcomingMovies = movieData.upcomingMovies.where((movie) {
      final title = movie['title'].toLowerCase();
      final searchTerm = _searchTerm.toLowerCase();
      return title.contains(searchTerm);
    }).toList();


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
                                        builder: (context) =>
                                            const TicketsPage()),
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

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Signed out.')),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()
                                    ),

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
                                        builder: (context) =>
                                            const TicketsPage()),
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
                              sign_up.image = File("images/CinemaTech.png");
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
              title: _isSearching
                  ? TextField(
                      autofocus: true, // Automatically focus the search field
                      onChanged: (text) {
                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          setState(() {
                            _searchTerm = text;
                          });
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search movies...',
                        hintStyle: const TextStyle(color: Colors.white),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _searchTerm = '';
                              _isSearching = false; // Close the search field
                            });
                          },
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    )
                  : const Text(
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
                color: Colors.deepPurple,
              ),
              actions: [
                if (!_isSearching)
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.deepPurple),
                  onPressed: () {
                    setState(() {
                      _isSearching = true; // Open the search field
                    });
                  },
                ),
              ],
            ),
            body: Container(
              child: ListView(
                children: [
                  _buildSectionHeader('Today\'s Movies'),
                  (_searchTerm.isEmpty)
                      ? _buildMovieCarousel(movieData.todaysMovies)
                      : _buildMovieCarousel(filteredTodaysMovies),
                  _buildSectionHeader('Upcoming Movies'),
                  (_searchTerm.isEmpty)
                      ? _buildMovieCarousel(movieData.upcomingMovies)
                      : _buildMovieCarousel(filteredUpcomingMovies),
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
          color: Colors.deepPurple, // Updated color
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
          return GestureDetector(
            // Wrap MovieCard with GestureDetector
            onTap: () {
              // Navigate to the desired page here
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => moviepage(
                    // Assuming MovieDetailsPage is your target page
                    title: movie['title'],
                    story: movie['story'],
                    posterUrl: movie['posterUrl'],
                    genre: movie['genre'],
                    rating: movie['rating'],
                    duration: movie['duration'],
                    date: movie['date'],
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

  @override
  void dispose() {
    _debounce
        ?.cancel(); // Cancel the debounce timer when the widget is disposed
    super.dispose();
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
