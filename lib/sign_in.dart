import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/sign_up.dart';

class sing_in extends StatefulWidget {
  const sing_in({super.key});


  @override
  State<sing_in> createState() => _sing_inState();
}

class _sing_inState extends State<sing_in> {
  bool _obsecureText = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  void _password_visibality() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SIGN IN",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Center(
                child: Icon(Icons.login,size: 200,)
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "email",
                  hintStyle: TextStyle(fontSize: 20, color: Colors.red)),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: _password,
              obscureText: _obsecureText,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  hintText: "password",
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
            Center(
              child: MaterialButton(
                onPressed: goto_home,
                color: Colors.red,
                child: Text(
                  "Sing In",
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

  void goto_home() {
    if (sign_up.email.text.trim() == _email.text.trim()){
        if(sign_up.password.text.trim() == _password.text.trim()) {
          Navigator.pushNamed(context, 'home');

      }
    }
  }
}
