import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/sign_up.dart';
import 'package:untitled1/adminpage.dart';
import 'package:untitled1/user_data.dart';
final UserData users = UserData();

class sing_in extends StatefulWidget {
  const sing_in({super.key});

  static String username = '';
  static String email = '';
  static File? image = null;
  static String phone = '';
  static String password = '';
  @override
  State<sing_in> createState() => _sing_inState();
}


class _sing_inState extends State<sing_in> {
  bool _obsecureText = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  void _password_visibality() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  void goto_home() {
    setState(() {
      _errorMessage = null;
    });

    if (_formKey.currentState!.validate()) {
      // Check if entered email and password match any user in the list
      final userMatch = users.Users.firstWhere(
            (u) => u['email'].toString().trim() == _email.text.trim() &&
            u['password'].toString().trim() == _password.text.trim(),
        orElse: () => {}, // Returns an empty map if no match found
      );

     if (userMatch.isNotEmpty) {
          // Valid user found - Retrieve their data
          sing_in.username = userMatch['username']; // Example: Store username
          sing_in.email = userMatch['email']; // Example: Retrieve the email
          sing_in.image = userMatch['image'] ?? null; // Example: Retrieve the email
          sing_in.phone = userMatch['phone'] ?? ''; // Example: Retrieve the email
          Navigator.pushNamed(context, 'home'); // Navigate to home
        } else {
        // Invalid credentials
        setState(() {
          _errorMessage = "Invalid email or password. Please try again.";
        });
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "images/SignIn.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            appBar: AppBar(
              title: const Text(
                'Sign In',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              backgroundColor: Colors.black.withOpacity(0.5),
              elevation: 10,
              iconTheme: const IconThemeData(
                color: Colors.deepPurple,
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 250,
                    ),
                    TextFormField(
                      controller: _email,
                      autofocus: true,
                      cursorColor: Colors.deepPurple,
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Email is required.";
                        }
                        if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value.trim()) && value !='admin') {
                          return "Enter a valid email address.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: _password,
                      obscureText: _obsecureText,
                      cursorColor: Colors.deepPurple,
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                          onPressed: _password_visibality,
                          icon: Icon(!_obsecureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Password is required.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: goto_home,
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
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
