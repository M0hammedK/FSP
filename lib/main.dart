import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled1/Home.dart';
import 'package:untitled1/sign_up.dart';
import 'package:untitled1/sign_in.dart';
import 'package:untitled1/adminpage.dart';

import 'TicketsPage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
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
