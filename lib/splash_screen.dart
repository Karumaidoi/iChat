import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ichat/Home/auth/home.dart';
import 'package:ichat/Home/auth/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late bool isVerified = false;
  bool? email;

  @override
  void initState() {
    checkIfUser();
    super.initState();
  }

  checkIfUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userEmail = preferences.getString('email');

    if (userEmail == null) {
      setState(() {
        email == false;
      });
    } else {
      setState(() {
        email = true;
      });
    }
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  email == false ? const SignUpPage() : const HomePage()));
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Flutter Fire',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
