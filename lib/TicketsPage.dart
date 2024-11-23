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
                color: Colors.black.withOpacity(0.6), // Background color
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  // Leading movie image (network only)
                  leading: Image.network(
                    ticket['movieimg'],
                    width: 70,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                  // Movie title
                  title: Text(
                    ticket['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Duration and date in subtitle
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.grey, size: 18), // Duration icon
                          const SizedBox(width: 8),
                          Text(
                            'Duration: ${ticket['duration']}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8), // Add some spacing between the rows
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.grey, size: 18), // Date icon
                          const SizedBox(width: 8),
                          Text(
                            'Date: ${ticket['date']}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
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
