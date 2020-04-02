import 'package:flutter/material.dart';
import './index.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          BannerWidget(),
          HomeProductWidget()
        ],
      )
    );
  }
}