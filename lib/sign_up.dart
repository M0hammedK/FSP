import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class sign_up extends StatefulWidget {
  static var username = _MyAppState._username;
  static var email = _MyAppState._email;
  static var password1 = _MyAppState._password1;
  static var password2 = _MyAppState._password2;
  static var phone = _MyAppState._phone;
  static var image = _MyAppState._image;

  const sign_up({super.key});

  // This widget is the root of your application.
  @override
  State<sign_up> createState() => _MyAppState();
}

class _MyAppState extends State<sign_up> {
  bool _obsecureText = true;
  static final TextEditingController _username = TextEditingController();
  static final TextEditingController _email = TextEditingController();
  static final TextEditingController _password1 = TextEditingController();
  static final TextEditingController _password2 = TextEditingController();
  static final TextEditingController _phone = TextEditingController();
  void _password_visibality() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }
  static XFile? _image;
  Future<void> _pickimage() async{
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    home:
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SIGN UP",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),

            _image != null ? Image.file(File(_image!.path), height: 100, width: 100,) : Text("No image selected"),
            SizedBox(
              height: 20),
            ElevatedButton(onPressed: _pickimage, child: Text("Pick image from Gallery")),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _username,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_circle),
                  hintText: "Username",
                  hintStyle: TextStyle(fontSize: 20, color: Colors.red)),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: _email,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  hintText: "Email",
                  hintStyle: const TextStyle(fontSize: 20, color: Colors.red),
                 ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: _password1,
              obscureText: _obsecureText,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  hintText: "Password",
                  hintStyle: const TextStyle(fontSize: 20, color: Colors.red),
                  suffixIcon: IconButton(
                      icon: Icon(_obsecureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: _password_visibality)),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: _password2,
              obscureText: _obsecureText,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  hintText: "Repeat Password",
                  hintStyle: const TextStyle(fontSize: 20, color: Colors.red),
                  suffixIcon: IconButton(
                      icon: Icon(_obsecureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: _password_visibality)),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: _phone,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone),
                  hintText: "Phone Number",
                  hintStyle: const TextStyle(fontSize: 20, color: Colors.red),
                  ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: MaterialButton(
                onPressed: ()=> Navigator.pushNamed(context, 'sign_in'),
                color: Colors.red,
                child: Text(
                  "Sing Up",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
