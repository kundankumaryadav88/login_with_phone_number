import 'package:flutter/material.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome to Home page",
          style: TextStyle(color: Colors.blueAccent, fontSize: 30),
        ),
      ),
    );
  }
}
