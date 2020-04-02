class ProductDetailModel {
  String code;
  String message;
  ProductDetail data;

  ProductDetailModel({this.data});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = ProductDetail.fromJson(json['data']);
    }
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['code'] = this.code;
    data['message'] = this.message;

    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ProductDetail {
  String productId;
  String name;
  String imgUrl;
  String desc;
  String type;
  String point;
  String productDetail;
  // 构造方法
  ProductDetail(
      {this.desc,
      this.imgUrl,
      this.name,
      this.point,
      this.productDetail,
      this.productId,
      this.type});

  // 通过传入json数据转换成数据模型
  ProductDetail.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    name = json['name'];
    imgUrl = json['imgUrl'];
    desc = json['desc'];
    type = json['type'];
    point = json['point'];
    productDetail = json['productDetail'];
  }

  // 将数据模型zhuanhuanchengjson
  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['productId'] = this.productId;
    data['name'] = this.name;
    data['imgUrl'] = this.imgUrl;
    data['desc'] = this.desc;
    data['type'] = this.type;
    data['point'] = this.point;
    data['productDetail'] = this.productDetail;
    return data;
  }
}
