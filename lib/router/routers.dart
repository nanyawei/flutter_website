// 路由定义
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_website/page/not_found.dart';
import 'package:flutter_website/router/router_handler.dart';

// 定义路径及跳转页面
class Routes {
  // 跟路径
  static String root = '/';
  // 产品详情
  static String detailsPage = '/detail';
  // 出错页面
  static String notFoundPage = '/notFound';

  // 配置路由
  static void configRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return NotFoundPage();
    });
    router.define(root, handler: rootHandler);
    router.define(detailsPage,
      handler: productDetailPage,
      // transitionType: TransitionType.inFromBottom
    );
  }
}