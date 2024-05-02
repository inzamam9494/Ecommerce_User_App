import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthRepo{
  static signUp(String email, password, firstName, lastName) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //  add user database
      if(credential.user?.uid!=null){
        await FirebaseFirestore.instance.collection('user').doc(credential.user!.uid).set({
          'uid' : credential.user!.uid,
          'firstName' : firstName,
          'lastName' : lastName,
          'email' : email,
          'password' : password
        });
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      print(e);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static signIn(String email, password) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wrong password provided for that user.')));

      }
    }
  }

}