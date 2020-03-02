import 'package:flutter/material.dart';
import 'package:flutter_website/loading.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    // 实例化路由
    // final router = Router



    return MaterialApp(
      title: 'Website',
      theme: ThemeData(
        primaryColor: Colors.redAccent
      ),
      home: Loading()
    );
  }
}