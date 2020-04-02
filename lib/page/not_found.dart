import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset(
          'assets/images/loading.jpg',
          fit: BoxFit.cover
        )
      ),
    );
  }
}