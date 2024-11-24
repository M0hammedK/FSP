import 'package:flutter/material.dart';
import 'movie_data.dart';
import 'package:intl/intl.dart';
import 'sign_up.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieData movieData = MovieData();
    final isAdmin = sign_up.username.text == "admin";
    final userEmail = sign_up.email.text.trim();
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
                  title: Container(
                    padding: EdgeInsets.fromLTRB(90, 0, 0, 0),
                    child: Text(
                      ticket['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Duration and date in subtitle
                  subtitle: Row(
                    children:[
                      (ticket['moviePost'].substring(0, 4) != "http")
                          ? Image.asset(ticket['moviePost'], height: 110, width: 70, fit: BoxFit.cover,)
                          : Image.network(ticket['moviePost'],
                          height: 110, width: 70, fit: BoxFit.cover),
                      SizedBox(width: 20,),
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5,),
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
                        const SizedBox(height: 12), // Add some spacing between the rows
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
                        const SizedBox(height: 15), // Add some spacing between the rows
                        Row(
                          children: [
                            SizedBox(height: 8,),
                            ...date_Validation(ticket['date'], ticket['duration']),
                            ],
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

List<Widget> date_Validation(String date, String movieduration) {
  if(getticketDate(date).isAfter(DateTime.now())){
    return[
      const Icon(Icons.check_box, color: Colors.grey, size: 18), // Date icon
      const SizedBox(width: 8),
      RichText(
          text: const TextSpan(
            children: [
              TextSpan(text: 'Validation: ', style: const TextStyle(color: Colors.grey)),
              TextSpan(text: 'Still', style: const TextStyle(color: Colors.green))
            ],
          ),
      ),
    ];
  }else{
    if (getticketDate_time(date, movieduration).isAfter(DateTime.now())) {
      return [
        const Icon(Icons.check_box_outline_blank_outlined, color: Colors.grey,
            size: 18),
        const SizedBox(width: 8),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(text: 'Validation: ',
                  style: const TextStyle(color: Colors.grey)),
              TextSpan(
                  text: 'OnGoing', style: const TextStyle(color: Colors.yellow))
            ],
          ),
        ),
      ];
    } else {
      return [
        const Icon(Icons.indeterminate_check_box, color: Colors.grey, size: 18),
        const SizedBox(width: 8),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(text: 'Validation: ',
                  style: const TextStyle(color: Colors.grey)),
              TextSpan(text: 'Gone', style: const TextStyle(color: Colors.red))
            ],
          ),
        ),
      ];
    }
  }
}

DateTime getticketDate(String date) {
  return DateFormat('dd/MM/yy HH:mm').parse(date);
}

DateTime getticketDate_time(String date, String movieduration) {
  DateTime dateObj = DateFormat('dd/MM/yy HH:mm').parse(date);

  // Parse the movie duration string
  DateTime durationObj = DateFormat('HH:mm:ss').parse(movieduration);

  // Extract hours and minutes from duration
  int hours = durationObj.hour;
  int minutes = durationObj.minute;

  // Add hours and minutes to date object
  DateTime ticketDate = dateObj.add(Duration(hours: hours, minutes: minutes));

  return ticketDate;
}
