import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/loading.jpg',
        fit: BoxFit.cover
      ),
    );
  }
}