import 'package:flutter/material.dart';
import 'package:ichat/API/google_signup.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                // var state = GoogleAuth().signOut();

                // Navigator.of(context)
                //     .pushReplacement(MaterialPageRoute(builder: (context) {
                //   return SplashPage();
                // }));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
