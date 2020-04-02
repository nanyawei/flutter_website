import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_website/model/product_detail_model.dart';
import 'package:flutter_website/provider/index.dart';
import 'package:flutter_website/service/http_service.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;
  ProductDetailPage({Key key, @required this.productId}):super(key: key);
  @override
  _ProductDetailPageState createState () => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  @override
  void initState () {
    super.initState();
    getProductDetail();
  }

  getProductDetail () async {
    final formData = {
      'productId': widget.productId
    };
    await request('productDetail', formData: formData, method: 'post').then((r) {
      var data = json.decode(r.toString());
      if (data != null) {
        final ProductDetailModel productDetail = ProductDetailModel.fromJson(data);
        Provider.of<ProductDetailProvider>(context, listen: false).getProductDetail(productDetail.data);
      }
    });
  }

  @override
  Widget build (BuildContext context) {
    print(widget.productId);
    return Scaffold(
      appBar: AppBar(
        title: Text('产品详情')
      ),
      body: Consumer<ProductDetailProvider>(
        builder: (BuildContext context, ProductDetailProvider productDetailProvider, Widget child) {
          final productDetail = productDetailProvider.productDetail;
          if (productDetail == null) {
            return Text('暂无数据');
          }
          print(productDetail.productDetail);
          return ListView(
            children: <Widget>[
              Html(
                data: 'aa',
                backgroundColor: Colors.white70,
              )
            ],
          );
        },
      )
    );
  }
}