import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_website/model/product.dart';
import 'package:flutter_website/router/application.dart';
import 'package:flutter_website/service/http_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_website/provider/index.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState () => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState () {
    super.initState();
    getProductList(false);
  }

  ScrollController _scrollController = ScrollController();
  GlobalKey _footerKey = GlobalKey();
  GlobalKey _listKey = GlobalKey();


  getProductList (bool isMore) async {
    const formData = {};
    await request('getProducts', formData: formData).then((r) {
      var data = json.decode(r.toString());

      if (data == null) {
        Provider.of<ProductProvider>(context, listen: false).getProductList([]);
      } else {
        // 将json数据转换为productListModel
        ProductListModel productList = ProductListModel.fromJson(data);
        // 将返回的数据放入productProvider
        if (isMore) {
          Provider.of<ProductProvider>(context, listen: false).addProductList(productList.data);
        } else {
          Provider.of<ProductProvider>(context, listen: false).getProductList(productList.data);
        }
      }
    });
  }



  @override
  Widget build (BuildContext context ){
    return Scaffold(
      body: Consumer<ProductProvider>(
        // 获取产品列表数据
        builder: (BuildContext context, ProductProvider productProvider, Widget child) {
          List<ProductModel> productList = productProvider.productList;
          if (productList.length > 0) {
            return Container(
              width: 400,
              // 加载刷新组件
              child: EasyRefresh(
                // 底部加载刷新处理
                footer: MaterialFooter(
                  key: _footerKey,
                  backgroundColor: Colors.white,
                  // linkNotifier: LinkFooterNotifier()
                ),
                child: ListView.separated(
                  key: _listKey,
                  controller: _scrollController,
                  itemCount: productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return listWidget(productList[index], index);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                      height: 1.0,
                      color: Colors.black26,
                    );
                  }
                ),
                // 加载更多
                onLoad: () async {
                  getProductList(true);
                },
              ),
            );
          } else {
            return Text('暂时没有数据');
          }
        },
      )
    );
  }

  // 商品列表项
  Widget listWidget (ProductModel item, int index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, '/detail?productId=${item.productId}');
      },
      child: ListTile(
        leading: FadeInImage.assetNetwork(
          placeholder: 'assets/images/banners/loading.gif',
          image: item.imageUrl ?? 'assets/images/banners/loading.gif'
        ),
        title: Text(item.name),
        subtitle: Text(item.desc),
        trailing: Text(item.point),
      ),
    );
  }
}