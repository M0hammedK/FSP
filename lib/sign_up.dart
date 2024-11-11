import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class sign_up extends StatefulWidget {
  static TextEditingController email = _SignUpPageState._email;
  static TextEditingController username = _SignUpPageState._username;
  static TextEditingController password = _SignUpPageState._password1;
  static TextEditingController phone = _SignUpPageState._phone;
  static File? image = _SignUpPageState._image;

  const sign_up({super.key});
  @override
  State<sign_up> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<sign_up> {
  final List<String> phones = ["70", "71", "73","77", "78"];
  static final TextEditingController _username = TextEditingController();
  static final TextEditingController _email = TextEditingController();
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "images/SignUP.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text('Sign Up', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 25),),
              backgroundColor: Colors.black.withOpacity(0.5),
              elevation: 10,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: getImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? const Icon(Icons.add_a_photo, size: 40)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _username,
                    cursorColor: Colors.deepPurple,
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Theater Name',
                      labelStyle: const TextStyle(color: Colors.deepPurple,
                        fontSize: 20, fontWeight: FontWeight.bold,),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _email,
                    cursorColor: Colors.deepPurple,
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.deepPurple,
                        fontSize: 20, fontWeight: FontWeight.bold,),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _password1,
                    cursorColor: Colors.deepPurple,
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.deepPurple,
                        fontSize: 20, fontWeight: FontWeight.bold,),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
                    ),
                    obscureText: true, // Hides password input
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _password2,
                    cursorColor: Colors.deepPurple,
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(color: Colors.deepPurple,
                        fontSize: 20, fontWeight: FontWeight.bold,),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _phone,
                    cursorColor: Colors.deepPurple,
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Contact Number',
                      labelStyle: const TextStyle(color: Colors.deepPurple,
                        fontSize: 20, fontWeight: FontWeight.bold,),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      gotosign_in();
                    },
                    child: const Text('Sign Up',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void gotosign_in() {
    if(_username.text.trim() != ""){
      if(_email.text.trim() != ""){
        if(_password1.text.trim() != "" && _password1.text.trim() == _password2.text.trim()){
          if(_phone.text.trim() != "" && _phone.text.length == 9){
            if(phones.contains(_phone.text.trim().substring(0,2))){
                
            }
          }
        }
      }
    }
  }
}
