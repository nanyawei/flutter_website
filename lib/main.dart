import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_website/loading.dart';
import 'package:flutter_website/router/application.dart';
import 'package:flutter_website/router/routers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_website/provider/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 实例化路由
    final router = Router();
    // 配置路由
    Routes.configRoutes(router);
    // 将路由设置成整个应用可以调用
    Application.router = router;

    // 管理多个共享数据类
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrentIndexProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (_) => WebSocketProvider())
      ],
      child: MaterialApp(
          title: 'Website',
          onGenerateRoute: Application.router.generator,
          theme: ThemeData(primaryColor: Colors.black),
          home: Loading()
      )
    );
  }
}