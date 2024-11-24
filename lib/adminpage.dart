import 'dart:async';

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
      body:Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "images/backgroundblack.jpg", // Add your background image path here
              fit: BoxFit.cover,
            ),
          ),
        Scaffold(
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
          body: Stack(
            children: [

              ListView(
                children: [
                  _buildSectionHeader('Today\'s Movies'),
                  (_searchTerm.isEmpty)
                      ? _buildMovieList(movieData.todaysMovies , 'today')
                      : _buildMovieList(filteredTodaysMovies, 'today'),
                  _buildSectionHeader('Upcoming Movies'),
                  (_searchTerm.isEmpty)
                      ? _buildMovieList(movieData.upcomingMovies, 'upcoming')
                      : _buildMovieList(filteredUpcomingMovies, 'upcoming'),
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
        ),
        ],
      )
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

  Widget _buildMovieRow(
      Map<String, dynamic> movie, int index, String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black
              .withOpacity(0.5), // Add a translucent white background
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Colors.black.withOpacity(0.2), width: 1), // Add border
        ),
        child: Row(
          children: [
            // Movie Poster
            (movie['posterUrl'].substring(0, 4) != "http")
                ? Image.asset(
                    movie['posterUrl'],
                    height: 200,
                    width: 180,
                    fit: BoxFit.cover,
                  )
                : Image.network(movie['posterUrl'],
                    height: 200, width: 180, fit: BoxFit.cover),
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
                      color: Colors.white
                    ),
                  ),
                  Text(
                    movie['genre'],
                    style: const TextStyle(fontSize: 14, color: Colors.red),
                  ),
                  Text(
                    'Rating: ${movie['rating']}',
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
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
    final TextEditingController storyController =
        TextEditingController(text: movie['story']);
    final TextEditingController genreController =
        TextEditingController(text: movie['genre']);
    final TextEditingController ratingController =
        TextEditingController(text: movie['rating'].toString());
    final TextEditingController durationController =
        TextEditingController(text: movie['duration']);
    final TextEditingController dateController =
        TextEditingController(text: movie['date']);
    final TextEditingController postUrlController =
        TextEditingController(text: movie['posterUrl']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Movie'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: storyController,
                  decoration: const InputDecoration(labelText: 'Story'),
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
                  controller: durationController,
                  decoration: const InputDecoration(labelText: 'Duration'),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                ),
                TextField(
                  controller: postUrlController,
                  decoration: const InputDecoration(labelText: 'PostUrl'),
                ),
              ],
            ),
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
                  movie['story'] = storyController.text;
                  movie['genre'] = genreController.text;
                  movie['rating'] = double.parse(ratingController.text);
                  movie['duration'] = durationController.text;
                  movie['date'] = dateController.text;
                  movie['posterUrl'] = postUrlController.text;
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
    final TextEditingController storyController = TextEditingController();
    final TextEditingController ratingController = TextEditingController();
    final TextEditingController posterUrlController = TextEditingController();
    final TextEditingController durationController = TextEditingController();
    final TextEditingController dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Movie'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: storyController,
                  decoration: const InputDecoration(labelText: 'Story'),
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
                  controller: durationController,
                  decoration: const InputDecoration(labelText: 'Duration'),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                ),
                TextField(
                  controller: posterUrlController,
                  decoration: const InputDecoration(labelText: 'Poster URL'),
                ),
              ],
            ),
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
                    'story': storyController.text,
                    'genre': genreController.text,
                    'rating': double.parse(ratingController.text),
                    'posterUrl': posterUrlController.text,
                    'duration': durationController.text,
                    'date': dateController.text,
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
