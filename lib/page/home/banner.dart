import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState () => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  SwiperControl _swiperControl = new SwiperControl();

  List<String> banners = [
    'assets/images/banners/police-huahua.jpeg',
    'assets/images/banners/police-paopao.jpeg',
    'assets/images/banners/police-maomao.jpeg',
  ];

  @override
  Widget build (BuildContext context) {
    // 计算宽高比 按比例
    double widht = MediaQuery.of(context).size.width;
    double height = widht * 540.0 / 1080.0;
    return Container(
      margin: EdgeInsets.only(left: 5.0, right: 5.0),
      width: widht,
      height: height,
      child: Swiper(
        control: _swiperControl,
        itemCount: banners.length,
        autoplay: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            banners[index],
            fit: BoxFit.cover,
            width: widht,
            height: height,
          );
        },
      ),
    );
  }
}