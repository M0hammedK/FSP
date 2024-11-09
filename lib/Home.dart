import 'dart:io';
import 'package:flutter/material.dart';
import 'package:untitled1/sign_up.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.all(10),
      //     children: <Widget>[
      //      UserAccountsDrawerHeader(
      //          accountName: Text(sign_up.username.text),
      //          accountEmail: Text(sign_up.email.text),
      //          currentAccountPicture: CircleAvatar(radius: 50, backgroundImage: sign_up.image != null ? FileImage(File(sign_up.image!.path)) : Image.asset("images/BATE3.jpg") as ImageProvider,),
      //      ),
      //       ListTile(
      //         title: Text("setting"),
      //         leading: Icon(Icons.settings_sharp),
      //         onTap: (){
      //           Navigator.pushNamed(context, 'sign_up');
      //         },
      //       )
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(

      ),
    );
  }
}

