import 'package:flutter/material.dart';
import '../model/product_detail_model.dart';

class ProductDetailProvider with ChangeNotifier {
  ProductDetail productDetail;

  getProductDetail(ProductDetail product) {
    productDetail = product;
    notifyListeners();
  }
}
