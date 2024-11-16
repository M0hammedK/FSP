import 'package:flutter/material.dart';

class moviepage extends StatelessWidget {
  final String title;
  final String posterUrl;
  final String genre;
  final double rating;const moviepage({
    Key? key,
    required this.title,
    required this.posterUrl,
    required this.genre,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(posterUrl), // Or Image.asset if localconst SizedBox(height: 20),
              Text(
                'Title: $title',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Genre: $genre',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'Rating: $rating',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle "Get Ticket" button press
                },
                child: const Text('Get Ticket'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}