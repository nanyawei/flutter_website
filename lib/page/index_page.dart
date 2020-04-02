import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_website/page/index.dart';
import 'package:flutter_website/provider/index.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState () => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  // 首页面
  HomePage homePage;
  // 产品页面
  ProductPage productPage;
  // 聊天页面
  ChatPage chatPage;
  // 用于判断webSocket是否初始化
  bool socketInited = false;

  // 根据当前索引返回不同页面
  currentPage () {
    int currentIndex = Provider.of<CurrentIndexProvider>(context).currentIndex;

    switch (currentIndex) {
      case 0:
        if (homePage == null) {
          homePage = HomePage();
        }
        return homePage;
      case 1:
        if (productPage == null) {
          productPage = ProductPage();
        }
        return productPage;
      case 2:
       if (chatPage == null) {
          chatPage = ChatPage();
        }
        return chatPage;
    }
  }

  BottomNavigationBarItem bottomItem (String title, IconData icon) {
    return BottomNavigationBarItem(
      title: Text(title),
      icon: Icon(icon)
    );
  }

  @override
  Widget build (BuildContext context) {
    /**
     * 初始化webSocket，需要做一个判断
     * 首次初始化完成，需要将socketInited设置为true
     * 否则当页面刷新时会导致webSocket多次连接创建多个实例
     */
    // if (!socketInited) {
    //   Provider.of<WebSocketProvider>(context).init();
    // }

    // 获取当前索引
    int currentIndex = Provider.of<CurrentIndexProvider>(context).currentIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text('企业站'),
        leading: Icon(Icons.home),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {print('搜索');},
              child: Icon(Icons.search)
            )
          )
        ],
      ),
      body: currentPage(),
      bottomNavigationBar: BottomNavigationBar(
        // 通过fixedColor设置选中中的颜色
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: ((index) {
          Provider.of<CurrentIndexProvider>(context, listen: false).changeIndex(index);
        }),
        items: [
          bottomItem('首页', Icons.home),
          bottomItem('产品', Icons.apps),
          bottomItem('联系我们', Icons.insert_comment),
        ],
      ),
    );
  }
}