class ProductListModel {
  String code;
  String message;
  List<ProductModel> data;

  ProductListModel({this.data});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];

    if (json['data'] != null) {
      data = List<ProductModel>();

      json['data'].forEach((v) {
        data.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson () {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJosn()).toList();
    }
    return data;
  }
}

class ProductModel {
  String productId;
  String desc;
  String type;
  String name;
  String imageUrl;
  String point;

  ProductModel({this.desc, this.imageUrl, this.name, this.point, this.productId, this.type});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    desc = json['desc'];
    type = json['type'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    point = json['point'];
  }

  Map<String, dynamic> toJosn () {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['productId'] = this.productId;
    data['desc'] = this.desc;
    data['type'] = this.type;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['point'] = this.point;

    return data;
  }
}