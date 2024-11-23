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
    required this.posterUrl, required this.duration, required this.date, required this.email,
      }) : super(key: key);

  @override
  State<paymentpage> createState() => _paymentpageState();
}

  @override
  State<paymentpage> createState() => _paymentpageState();

class _paymentpageState extends State<paymentpage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Card Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a card number';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Expiry Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an expiry date';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'CVV'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a CVV';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _isLoading = true;
                });
                // Simulate payment processing delay
                Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    _isLoading = false;
                  });

                  // Add the ticket to MovieData
                  MovieData().Tickets.add({
                    'title': widget.title, // Movie title
                    'userEmail': sign_up.email.text,
                    'movieimg':widget.posterUrl,
                    'duration':widget.duration,
                    'date':widget.date
                  });

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment Successful! Ticket added.')),
                  );
                  Navigator.pushNamed(context, 'home');


                });
              }

            },
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Get Now'),
          ),
            ],
          ),
        ),
      ),
    );
  }
}