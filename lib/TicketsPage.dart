import 'package:flutter/material.dart';
import 'movie_data.dart';
import 'sign_up.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieData movieData = MovieData();
    final userEmail = sign_up.email.text.trim();

    // Filter tickets for the logged-in user
    final userTickets = movieData.Tickets
        .where((ticket) => ticket['userEmail'] == userEmail)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Tickets'),
        backgroundColor: Colors.black.withOpacity(0.8),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "images/backgroundblack.jpg",
              fit: BoxFit.cover,
            ),
          ),
          userTickets.isEmpty
              ? const Center(
            child: Text(
              'No tickets yet!',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: userTickets.length,
            itemBuilder: (context, index) {
              final ticket = userTickets[index];
              return Card(
                color: Colors.black.withOpacity(0.6),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.movie,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    ticket['title'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'User: ${ticket['userEmail']}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
