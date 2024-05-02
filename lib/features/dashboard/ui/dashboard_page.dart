import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard_Page extends StatefulWidget {
  const Dashboard_Page({super.key});

  @override
  State<Dashboard_Page> createState() => _Dashboard_PageState();
}

class _Dashboard_PageState extends State<Dashboard_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dashboard",
        style: TextStyle(
          color: Colors.white
        ),),
        elevation: 2,
        shadowColor: Colors.black,
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          }, icon: const Icon(Icons.login_outlined, color: Colors.white,))
        ],
      ),
    );
  }
}
