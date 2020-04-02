// 路由handler

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_website/page/index_page.dart';
import 'package:flutter_website/page/product_detail_page.dart';


// 跟路由handler返回IndexPage页面
Handler rootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return IndexPage();
  }
);

// 产品路由handler返回产品详情页面，传入productId参数
Handler productDetailPage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    // productid
    final productId = params['productId'].first;
    return ProductDetailPage(productId: productId);
  }
);