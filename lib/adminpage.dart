import 'package:flutter/material.dart';
import 'movie_data.dart';
import 'home.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final MovieData movieData = MovieData(); // Access the singleton

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel',style: TextStyle(color:Colors.white)),
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the Home Page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "images/backgroundblue.jpg", // Add your background image path here
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            children: [
              _buildSectionHeader('Manage Today\'s Movies'),
              _buildMovieList(movieData.todaysMovies, 'today'),
              _buildSectionHeader('Manage Upcoming Movies'),
              _buildMovieList(movieData.upcomingMovies, 'upcoming'),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addMovieDialog(); // Show the Add Movie dialog
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.indigo,
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
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMovieList(List<Map<String, dynamic>> movies, String category) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return _buildMovieRow(movie, index, category);
      },
    );
  }

  Widget _buildMovieRow(Map<String, dynamic> movie, int index, String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8), // Add a translucent white background
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black.withOpacity(0.2), width: 1), // Add border
        ),
        child: Row(
          children: [
            // Movie Poster
            Image.asset(
              movie['posterUrl'],
              height: 140,
              width: 110,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            // Movie Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    movie['genre'],
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Rating: ${movie['rating']}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            // Edit Button
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                _editMovie(movie, index, category);
              },
            ),
            // Delete Button
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _deleteMovie(index, category);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editMovie(Map<String, dynamic> movie, int index, String category) {
    final TextEditingController titleController =
    TextEditingController(text: movie['title']);
    final TextEditingController genreController =
    TextEditingController(text: movie['genre']);
    final TextEditingController ratingController =
    TextEditingController(text: movie['rating'].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Movie'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: genreController,
                decoration: const InputDecoration(labelText: 'Genre'),
              ),
              TextField(
                controller: ratingController,
                decoration: const InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  movie['title'] = titleController.text;
                  movie['genre'] = genreController.text;
                  movie['rating'] = double.parse(ratingController.text);
                });
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteMovie(int index, String category) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Movie'),
          content: const Text('Are you sure you want to delete this movie?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (category == 'today') {
                    movieData.todaysMovies.removeAt(index);
                  } else if (category == 'upcoming') {
                    movieData.upcomingMovies.removeAt(index);
                  }
                });
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _addMovieDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController genreController = TextEditingController();
    final TextEditingController ratingController = TextEditingController();
    final TextEditingController posterUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Movie'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: genreController,
                decoration: const InputDecoration(labelText: 'Genre'),
              ),
              TextField(
                controller: ratingController,
                decoration: const InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: posterUrlController,
                decoration: const InputDecoration(labelText: 'Poster URL'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  final newMovie = {
                    'title': titleController.text,
                    'genre': genreController.text,
                    'rating': double.parse(ratingController.text),
                    'posterUrl': posterUrlController.text,
                  };
                  movieData.todaysMovies.add(newMovie); // Add to today's movies
                });
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Add Movie'),
            ),
          ],
        );
      },
    );
  }
}
