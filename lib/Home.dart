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
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(height: 80,),
                Icon(Icons.settings,),
                SizedBox(width: 20,),
                Icon(Icons.tab),
                SizedBox(width: 20,),
                Icon(Icons.supervised_user_circle),
                SizedBox(width: 270,),
                Icon(Icons.home),
              ],
            ),
            Text(
              "Google",
              style: TextStyle(fontSize: 50, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

