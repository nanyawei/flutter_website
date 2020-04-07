import 'package:flutter/material.dart';
// import 'package:flutter_website/config/configure.dart';
import 'package:flutter_website/utils/random_string.dart';
import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart';
import 'dart:convert';


// 聊天数据处理
class WebSocketProvider with ChangeNotifier {
  var userId = ''; // 用户id
  var userName = ''; // 用户名称
  var messages = []; // 聊天消息
  IOWebSocketChannel channel; // webSocket对象
  // 初始化
  init () async {
    print('初始化初始化初始化初始化初始化初始化初始化初始化初始化初始化初始化');
    // 使用随机数创建用户ID
    userId = RandomDigits.getString(6);
    // 使用随机数创建username
    userName = 'u_' + RandomDigits.getString(6);
    return await createWebsocket();
  }

  // 创建并连接socket服务器
  Future createWebsocket () async {
    // 连接socket服务器 
    // channel = IOWebSocketChannel.connect('ws://${Config.IP}:${Config.PORT}/api/websocket');
    channel = IOWebSocketChannel.connect('wss://echo.websocket.org');
    // 定义加入房间消息
    var message = {
      'type': 'joinRoom',
      'userId': userId,
      'userName': userName
    };
    // json编码
    String text = json.encode(message).toString();
    // 发消息到服务器
    channel.sink.add(text);
    print(' ============================== 开启连接 ====================================');
    channel.stream.listen(
      (data) => listenMessage(data),
      onError: onError,
      onDone: onDone
    );

  }

  // 监听服务端返回消息
  void listenMessage (data) {
    print('listenMessage:'+data);
    // Json解码
    var message = jsonDecode(data);
    // 接收到消息，判断消息类型为公共聊天
    if (message['type'] == 'chat_public') {
      // 插入消息至消息列表
      messages.insert(0, message);
    }
    // 通知聊天页面刷新数据
    notifyListeners();
  }

  // 监听消息错误回调方式
  void onError (err) {
    print('Error::::::::$err');
  }

  // 当Websocket断开时的回调方法，此时可以做重连处理
  void onDone () {
    print('Websocket断开了.........');
  }

  // 前端主动关闭websocket
  void closeWebSocket () {
    // 关闭连接
    channel.sink.close();
    print('关闭websocket');
    notifyListeners();
  }

  // 发送消息
  void sendMessage (type, data) async {
    // 定义发送消息对象
    var message = {
      'type': 'chat_public',
      'userId': userId,
      'userName': userName,
      // 消息内容
      'msg': data
    };

    // json 编码
    String text = json.encode(message).toString();
    print('send message:' + text);
    // 发送消息至服务器
    channel.sink.add(text);
  }
}