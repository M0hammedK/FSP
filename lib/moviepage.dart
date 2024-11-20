import 'package:flutter/material.dart';
import 'package:untitled1/paymentpage.dart';
import 'package:untitled1/sign_up.dart';

class moviepage extends StatelessWidget {
  final String title;
  final String posterUrl;
  final String genre;
  final double rating;
  final String story; // Add story property

  const moviepage({
    Key? key,
    required this.title,
    required this.posterUrl,
    required this.genre,
    required this.rating,
    required this.story, // Require story in constructor
  }) : super(key: key);

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
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(title,
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            backgroundColor: Colors.black.withOpacity(0.8),
            elevation: 10,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 5,
                              offset: const Offset(5, 5),
                            ),
                          ],
                        ),
                        child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001) // Perspective
                            ..rotateY(0.1), // Rotate slightly
                          alignment: FractionalOffset.center,
                          child: Image.asset(
                            posterUrl,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Genre: $genre',
                      style: const TextStyle(fontSize: 22, color: Colors.red),
                    ),
                    Text(
                      'Rating: $rating',
                      style: const TextStyle(fontSize: 22, color: Colors.blue),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Story:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      story,
                      style: const TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    const SizedBox(height: 30),
                    Center(// Center the button
                      child: ElevatedButton(
                        style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.deepPurple)),
                        onPressed: () {
                          (sign_up.username.text != "")?
                          Navigator.push( context, MaterialPageRoute(builder: (context) => paymentpage(title: title, posterUrl: posterUrl,email:sign_up.email.text),),)
                              :
                            Navigator.pushNamed(context, 'sign_in');
                        },
                        child: const Text('Get Ticket', style: TextStyle(fontSize: 22, color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]
      )
    );
  }
}