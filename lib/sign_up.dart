import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/sign_in.dart';
import 'package:untitled1/user_data.dart';

final UserData users = UserData();

class sign_up extends StatefulWidget {
  static TextEditingController email = _SignUpPageState._email;
  static TextEditingController username = _SignUpPageState._username;
  static TextEditingController password = _SignUpPageState._password1;
  static File? image;

  sign_up({super.key});

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
  bool _obsecureText = true;

  void _passwordVisibility() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        sign_up.image = File(pickedFile.path);
      } else {
        sign_up.image = null; // Reset the image if no file was picked
      }
    });
  }


  void validateAndSignUp() {
    final phone = _phone.text.trim();

    if (_username.text.trim() == "") {
      _showSnackBar("Username cannot be empty");
      return;
    }

    if (_username.text.trim().length < 4) {
      _showSnackBar("Username should be 4 characters at least");
      return;
    }

    if (_username.text.trim() == "admin") {
      _showSnackBar("Username cannot be admin");
      return;
    }

    if (_email.text.trim() == "") {
      _showSnackBar("Email cannot be empty");
      return;
    }
    final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(_email.text.trim())) {
      _showSnackBar('Enter a valid email in XX@XX.xx format.');
      return;
    }

      final userMatch = users.Users.firstWhere(
            (u) => u['email'].toString().trim() == _email.text.trim()
        orElse: () => {}, // Returns an empty map if no match found
      );

if(userMatch != null)
{
_showSnackBar('this email is already exist!.');
      return
}
    if (_password1.text.trim().length < 6 ) {
      _showSnackBar("Passwords must be 6 characters at least");
      return;
    }

    if (_password1.text.trim() != _password2.text.trim()) {
      _showSnackBar("Passwords do not match or are empty");
      return;
    }

    if (phone.isEmpty || phone.length != 9) {
      _showSnackBar("Invalid phone number. Must have at least 8 digits");
      return;
    }

    final phonePrefix = phone.substring(0, 2);

    if (!phones.contains(phonePrefix)) {
      _showSnackBar("Invalid phone number. Must start with one of ${phones.join(', ')}");
      return;
    }

    if (sign_up.image == null) {
      _showSnackBar("Please select an image");
      return;
    }
    // If all validations pass
    users.Users.add({
      'username': _username.text, // Movie title
      'email': _email.text,
      'password': _password1.text,
      'image':sign_up.image,
      'phone':_phone.text
    });

    _username.text = "";
    _email.text = "";
    _password1.text = "";
    _password2.text = "";
    _phone.text = "";
    sing_in.image = null;
    Navigator.pushNamed(context, "sign_in");
  }



  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
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
              title: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              backgroundColor: Colors.black.withOpacity(0.5),
              elevation: 10,
              iconTheme: const IconThemeData(
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
                        sign_up.image != null ? FileImage(sign_up.image!) : null,
                        child: sign_up.image == null
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
                        prefixIcon: const Icon(Icons.account_circle),
                        labelText: 'Username',
                        labelStyle: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _phone,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.deepPurple,
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        labelText: 'Phone Number',
                        labelStyle: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
                        prefixIcon: const Icon(Icons.password),
                        labelStyle: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        suffixIcon: IconButton(
                          onPressed: _passwordVisibility,
                          icon: Icon(!_obsecureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
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
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                          onPressed: _passwordVisibility,
                          icon: Icon(!_obsecureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: validateAndSignUp,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
