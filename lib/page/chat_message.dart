import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  // 判断是否是自己发送的消息
  bool isMe;
  // 用户名
  String userName;
  // 消息内容
  String message;
  // 创建时间
  String createAt;

  // 构建函数，传入参数
  ChatMessage({this.createAt, this.isMe, this.message, this.userName});

  @override
  Widget build (BuildContext context) {
    if (isMe) {
      // 自己发送的消息放在消息列表的右边
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        // 水平布局，左侧为消息，右侧为头像
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 左侧空余部分
            Expanded(child: Container()),
            // 垂直排列消息时间和消息内容
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(createAt, style: Theme.of(context).textTheme.subhead),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text(message)
                )
              ]
            ),
            // 头像
            Container(
              margin: EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                child: Text('Me')
              ),
            )
          ]
        ),
      );
    }
    // 别人发送的消息，左侧为头像，右侧为时间和消息
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        // 水平布局，左侧为消息，右侧为头像
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 头像
            Container(
              margin: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                // 用户名填充头像
                child: Text(userName)
              ),
            ),
            // 垂直排列消息时间和消息内容
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(createAt, style: Theme.of(context).textTheme.subhead),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text(message)
                )
              ]
            ),
          ]
        ),
    );
  }
}