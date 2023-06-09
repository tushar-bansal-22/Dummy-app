import 'package:flutter/material.dart';
import 'package:untitled/repository/products_repository.dart';

import '../models/productModel.dart';

class ProductProvider extends ChangeNotifier{

  List<ProductModel> products =[];
  bool isLoading = true;

  Future<List<ProductModel>> getProducts() async{
    ProductRepository productRepository = ProductRepository();
    products = await productRepository.getProducts();
    isLoading = false;
    notifyListeners();
    return products;
}

  void changedProducts() {
    isLoading =true;
    getProducts();
  }

}