import 'package:flutter/material.dart';
import 'movie_data.dart';
import 'sign_up.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieData movieData = MovieData();
    final isAdmin = sign_up.username.text == "admin";
    final userEmail = sign_up.email.text.trim();

    // Get tickets based on role
    final tickets = isAdmin
        ? movieData.Tickets // Admin sees all tickets
        : movieData.Tickets
        .where((ticket) => ticket['userEmail'] == userEmail)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isAdmin ? 'All Tickets' : 'Your Tickets',
          style: const TextStyle(color: Colors.deepPurple),
        ),
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
          tickets.isEmpty
              ? Center(
            child: Text(
              isAdmin
                  ? 'No tickets available!'
                  : 'No tickets yet!',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
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
