import 'package:flutter/material.dart';
import 'package:flutter_website/page/chat_message.dart';
import 'package:flutter_website/provider/index.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState () => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  // 文本编辑控制器
  final TextEditingController _textEditingController = TextEditingController();
  // 输入框获取焦点
  FocusNode textFocusNode = FocusNode();

  @override
  void initState () {
    super.initState();
      Provider.of<WebSocketProvider>(context, listen: false).init();
  }
  @override
  void dispose () {
    super.dispose();
  }

  // 发送消息
  void handleSubmit (String text) {
    // 判断输入消息是否为空
    if(text.isNotEmpty) {
      _textEditingController.clear();
      // 发送数据
      Provider.of<WebSocketProvider>(context, listen: false).sendMessage('chat_public', text);
    }
  }

  // 输入框组件
  Widget textComperWidget () {
    return IconTheme(
      data: IconThemeData(color: Colors.blue),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                decoration: InputDecoration.collapsed(hintText: '请输入消息'),
                onSubmitted: handleSubmit,
                controller: _textEditingController,
                focusNode: textFocusNode,
              )
            ),
            // 发送按钮
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send), 
                onPressed: () => handleSubmit( _textEditingController.text )
              )
            )
          ],
        )
      ),
    );
  }

  // 根据索引 创建一个带动画的消息组件
  Widget messageItem (BuildContext context, int index) {
    // 获取一条聊天消息
    final item = Provider.of<WebSocketProvider>(context, listen: false).messages[index];
    // 创建消息动画控制器
    var animate = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    // 创建一个消息组件
    ChatMessage message = ChatMessage(
      userName: item['userName'].toString(),
      // 取消息内容值
      message: item['msg'].toString(),
      // 创建消息时间
      createAt: formatDate(DateTime.now(), [ HH, ':', nn, ':', ss ])
    ,
    );
    // 读取自己的id 用来判断服务器端转发过来的消息是不是自己发送的消息
    String tempId = Provider.of<WebSocketProvider>(context, listen: false).userId;

    if (tempId == item['userId']) {
      message.isMe = true;
    } else {
      message.isMe = false;
    }
    // 最新的消息 执行动画
    if (index == 0) {
      // 开始动画
      animate.forward();
      // 大小变化动画组件
      return SizeTransition(
        // 指定非线性动画类型
        sizeFactor: CurvedAnimation(parent: animate, curve: Curves.easeInOut),
        axisAlignment: 0.0,
        // 指定为当前消息组件
        child: message
      );
    }
    // 不添加动画消息组件
    return message;
  }

  @override
  Widget build (BuildContext context) {
    return Column(
      children: <Widget>[
        // 使用consumer获取websocket对象
        Consumer<WebSocketProvider>(
          builder: (BuildContext context, WebSocketProvider webSocketProvider, Widget child) {
            // 获取消息列表数据
            final messages = webSocketProvider.messages;
            print(messages);
            return Flexible(
              // 使用列表渲染消息
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemCount: messages.length,
                itemBuilder: messageItem
              ),
            );
          },
        ),
        // 分割线
        Divider(height: 1.0),
        // 输入消息框及发送按钮
        Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: textComperWidget()
        )
      ],
    );
  }
}