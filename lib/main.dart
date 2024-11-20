import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled1/Home.dart';
import 'package:untitled1/sign_up.dart';
import 'package:untitled1/sign_in.dart';
import 'package:untitled1/adminpage.dart';
import 'package:untitled1/moviepage.dart';
import 'package:untitled1/paymentpage.dart';
import 'package:image/image.dart' as img;

import 'TicketsPage.dart';


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
    setState(() {});
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'sign_up': (context) => sign_up(),
        'home': (context) => Home(),
        'sign_in': (context) => sing_in(),
        'adminpage': (context) => AdminPage(),
        'TicketsPage': (context) => TicketsPage(),
      },
      home: Home(),
    );
  }
}
