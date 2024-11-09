import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class sign_up extends StatefulWidget {
  static TextEditingController email = _SignUpPageState._email;
  static TextEditingController username = _SignUpPageState._username;
  static TextEditingController location = _SignUpPageState._location;
  static TextEditingController password = _SignUpPageState._password1;
  static TextEditingController phone = _SignUpPageState._phone;
  static File? image = _SignUpPageState._image;

  const sign_up({super.key});

  @override
  State<sign_up> createState() => _SignUpPageState();}


class _SignUpPageState extends State<sign_up> {
  static final TextEditingController _username = TextEditingController();
  static final TextEditingController _email = TextEditingController();
  static final TextEditingController _location = TextEditingController();
  static final TextEditingController _password1 = TextEditingController();
  static final TextEditingController _password2 = TextEditingController();
  static final TextEditingController _phone = TextEditingController();
  static File? _image;

  Future getImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theater Sign Up'),
      ),
      body: Container( // Add Container here
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/down.jpg'), // Replace with your image path
            fit: BoxFit.cover, // Adjust fit as needed
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: getImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? const Icon(Icons.add_a_photo, size: 40)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _username,
              decoration: const InputDecoration(
                labelText: 'Theater Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _password1,
              decoration: const InputDecoration(
                labelText: 'Password',border: OutlineInputBorder(),
              ),
              obscureText: true, // Hides password input
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _password2,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _location,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _phone,
              decoration: const InputDecoration(
                labelText: 'Contact Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "sign_in");
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
      ),
    );
  }
}