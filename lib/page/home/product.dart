import 'package:flutter/material.dart';
import 'package:flutter_website/model/product.dart';
import 'package:flutter_website/router/application.dart';
import 'package:flutter_website/service/http_service.dart';
import 'package:flutter_website/utils/utils.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter_website/provider/index.dart';

class HomeProductWidget extends StatefulWidget {
  @override
  _HomeProductWidgetState createState () => _HomeProductWidgetState();
}

class _HomeProductWidgetState extends State<HomeProductWidget> {
  @override
  void initState () {
    super.initState();
    print('重载更新数据---------------');
    getProductList();
  }

  void getProductList () async {
    // 请求参数 
    var formData = {};
    // 调用请求方法传入url及表单
    await request('product', formData: formData).then((r) {
      // Json解码，value 为服务端返回数据
      var data = json.decode(r.toString());
      if (data == null) {
        Provider.of<ProductProvider>(context, listen: false).getProductList([]);
      } else {
        // 打印数据
        // 将json数据转换为productListModel
        ProductListModel productList = ProductListModel.fromJson(data);
        // 将返回的数据放入productProvider
        Provider.of<ProductProvider>(context, listen: false).getProductList(productList.data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 设备宽度
    double deviceWidth = MediaQuery.of(context).size.width;
    // 使用Consumer获取ProductProvider对象
    return Consumer<ProductProvider>(
      builder: (BuildContext context, ProductProvider productProvider, Widget child) {
        List<ProductModel> productList = productProvider.productList;
        return Container(
          width: deviceWidth,
          color: Colors.white,
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 7.5),
          child: buildProductList(context, deviceWidth, productList),
        );
      },
    );
  }

  Widget buildProductList (BuildContext context, double deviceWidth, List<ProductModel> productList) {
    // Item宽度
    double itemWidth = deviceWidth * 168.5 / 360;
    double imageWidth = deviceWidth * 110.0 / 360;

    List<Widget> listWidgets = productList.map((item) {
      var bgColor = Color.fromRGBO(255, 255, 255, 0);
      Color titleColor = string2Color('#db5d41');
      Color subtitleColor = string2Color('#999999');
      return InkWell(
        onTap: () {
          //路由跳转到详情页
          Application.router.navigateTo(context, '/detail?productId=${item.productId}');
        },
        child: Container(
          width: itemWidth,
          margin: EdgeInsets.only(bottom: 5.0, left: 2.0),
          color: bgColor,
          child: Column(
            children: <Widget>[
              Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15.0, color: titleColor)),
              Text(item.desc, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15.0, color: subtitleColor)),
              Container(
                alignment: Alignment(0, 0),
                margin: EdgeInsets.only(top: 5.0),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/banners/loading.gif',
                  image: item.imageUrl,
                  width: imageWidth,
                  height: imageWidth,
                  fit: BoxFit.cover,
                ),
              )
            ]
          ),
        ),
      );
    }).toList();
    
    return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
            child: Text(
              '最新产品',
              style: TextStyle(fontSize: 18.0, color: Color.fromRGBO(51, 51, 51, 1))
            )
          ),
          // 流式布局
          Wrap(
            spacing: 2,
            children: listWidgets
          )
        ]
    );
  }
}