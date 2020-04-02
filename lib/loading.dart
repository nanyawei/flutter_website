import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter_website/router/application.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState () => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState () {
    super.initState();

    Future.delayed(
      Duration(seconds: 2), () {
        print('flutter 企业站启动');
        // 使用路由跳转到应用主页面
        Application.router.navigateTo(context, '/');
      }
    );
  }

  @override
  Widget build (BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Image.asset('assets/images/loading.jpg'),
          Positioned(
            top: 100,
            child: Container(
              width: 400,
              child: Center(
                child: Text(
                  'Flutter 企业站',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    decoration: TextDecoration.none
                  )
                )
              )
            )
          )
        ]
      ),
    );
  }
}
