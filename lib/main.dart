import 'package:flutter/material.dart';
import 'package:untitled1/Home.dart';
import 'package:untitled1/sign_up.dart';
import 'package:untitled1/sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _obsecureText = true;
  void _password_visibality() {
    setState(() {
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'sign_up',
      routes: {
        'sign_up': (context) => sign_up(),
        'home': (context) => Home(),
        'sign_in': (context) => sing_in(),
      },
      home: MyhomePage(),
    );
  }
}

class MyhomePage extends StatefulWidget {
  const MyhomePage({super.key});

  @override
  State<MyhomePage> createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: null,
    );
  }
}

