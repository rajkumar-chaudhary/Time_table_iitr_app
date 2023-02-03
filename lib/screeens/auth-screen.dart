import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:provider/provider.dart';
import '../widgets/authForm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/schedule_provider.dart';

class AuthScreen extends StatefulWidget {
  // const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void submitFunction(
    String email,
    String password,
    String enroll,
    String branch,
    String year,
    bool isLogin,
  ) async {
    UserCredential authResult;
    if (isLogin) {
      authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } else {
      authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    }
    // final user = await FirebaseAuth.instance.currentUser;
    // String userName = 'Unknown User';
    // if (user != null) {
    //   userName = user.displayName!;
    // }
    if (!isLogin)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set({
        'email': email,
        'enroll': enroll,
        'branch': branch,
        'year': year,
        // 'userName': userName,
      });
    // print(userName);
    // Provider.of<ScheduleProvider>(context).setUserName(enroll);
    // ScheduleProvider().setUserName(enroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.all(8),
      children: [
        SizedBox(
          height: 100,
        ),
        AuthForm(
          submitFunction,
        ),
      ],
    ));
  }
}
