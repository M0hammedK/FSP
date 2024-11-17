import 'package:flutter/material.dart';

class paymentpage extends StatefulWidget {
  final String title;
  final String posterUrl;

  const paymentpage({
    Key? key,
    required this.title,
    required this.posterUrl,
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
              ElevatedButton(onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                  });
                  // Simulate payment processing delay
                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      _isLoading = false;
                    });
                    // Show success message or navigate to confirmation page
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment Successful!')),
                    );
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