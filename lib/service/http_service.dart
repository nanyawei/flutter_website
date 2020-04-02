
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter_website/config/configure.dart';
// import 'package:flutter_website/config/configure.dart';

final baseUrl = 'http://${Config.IP}:${Config.PORT}/api/';

Future request (url, {formData, String method}) async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType = 'application/json';

    if (method != null) {
      response = await dio.request(baseUrl+url, options: Options(method: method), queryParameters: formData);

    } else {
      response = await dio.get(baseUrl+url);
    }

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('后端接口异常，请检查测试代码和服务器运行情况...');
    }
  }catch(e) {
    return print('ERROR:::$e');
  }
}