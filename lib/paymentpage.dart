import 'package:flutter/material.dart';
import './movie_data.dart';
import 'sign_up.dart';
import 'sign_in.dart';

class paymentpage extends StatefulWidget {
  final MovieData movieData = MovieData(); // Reference the singleton

  final String title;
  final String posterUrl;
  final String duration;
  final String date;
  final String email;

  paymentpage({
    Key? key,
    required this.title,
    required this.posterUrl,
    required this.duration,
    required this.date,
    required this.email,
  }) : super(key: key);

  @override
  State<paymentpage> createState() => _paymentpageState();
}

class _paymentpageState extends State<paymentpage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

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
              title: const Text(
                'Payment',
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
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Details',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Card Number',
                        hintText: 'XXXX XXXX XXXX XXXX', // Add hint text
                        filled: true, // Fill the background
                        fillColor: Colors.grey[200], // Light grey background
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded corners
                          borderSide: BorderSide.none, // Remove default border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Colors
                                  .deepPurple), // Deep purple border on focus
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a card number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Expiry Date',
                        hintText: 'MM/YYYY', // Add hint text
                        filled: true, // Fill the background
                        fillColor: Colors.grey[200], // Light grey background
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded corners
                          borderSide: BorderSide.none, // Remove default border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Colors
                                  .deepPurple), // Deep purple border on focus
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Expiry Date of card';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        hintText: 'XXX', // Add hint text
                        filled: true, // Fill the background
                        fillColor: Colors.grey[200], // Light grey background
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded corners
                          borderSide: BorderSide.none, // Remove default border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Colors
                                  .deepPurple), // Deep purple border on focus
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a CVV number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.deepPurple, // Deep purple button background
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15), // Button padding
                        textStyle:
                            const TextStyle(fontSize: 18), // Button text size
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Rounded button corners
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          Future.delayed(const Duration(seconds: 1), () {
                            setState(() {
                              _isLoading = false;
                            });
                            MovieData().Tickets.add({
                              'title': widget.title, // Movie title
                              'userEmail': sign_up.email.text,
                              'moviePost': widget.posterUrl,
                              'duration': widget.duration,
                              'date': widget.date
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Payment Successful! Ticket added.')),
                            );
                            Navigator.pushNamed(context, 'home');
                          });
                        }
                      },
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white) // White loading indicator
                          : const Text('Get Now',
                              style: TextStyle(
                                  color: Colors.white)), // White button text
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
