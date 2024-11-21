import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class sign_up extends StatefulWidget {
  static TextEditingController email = _SignUpPageState._email;
  static TextEditingController username = _SignUpPageState._username;
  static TextEditingController password = _SignUpPageState._password1;
  static TextEditingController phone = _SignUpPageState._phone;
  static File? image = _image;

  const sign_up({super.key});

  static File? get _image => _SignUpPageState._image;
  @override
  State<sign_up> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<sign_up> {
  final List<String> phones = ["70", "71", "73", "77", "78"];
  static final TextEditingController _username = TextEditingController();
  static final TextEditingController _email = TextEditingController();
  static final TextEditingController _password1 = TextEditingController();
  static final TextEditingController _password2 = TextEditingController();
  static final TextEditingController _phone = TextEditingController();
  static File? _image;
  bool _obsecureText = true;

  void _password_visibality() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

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
              iconTheme: const IconThemeData(
                // Change drawer icon color here
                color: Colors.deepPurple,
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
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
                      autofocus: true,
                      cursorColor: Colors.deepPurple,
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        labelText: 'Username',
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
                        prefixIcon: Icon(Icons.email_outlined),
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
                      obscureText: _obsecureText,
                      cursorColor: Colors.deepPurple,
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password),
                        labelStyle: const TextStyle(color: Colors.deepPurple,
                        fontSize: 20, fontWeight: FontWeight.bold,),
                        suffixIcon: IconButton(onPressed: _password_visibality, icon: Icon(!_obsecureText ? Icons.visibility :  Icons.visibility_off)),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _password2,
                      obscureText: _obsecureText,
                      cursorColor: Colors.deepPurple,
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(onPressed: _password_visibality, icon: Icon(!_obsecureText ? Icons.visibility :  Icons.visibility_off)),
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(color: Colors.deepPurple,
                          fontSize: 20, fontWeight: FontWeight.bold,),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                Navigator.pushNamed(context, "sign_in");
            }
          }
        }
      }
    }
  }
}
