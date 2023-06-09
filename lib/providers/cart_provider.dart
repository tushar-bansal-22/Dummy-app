import 'package:flutter/material.dart';
import 'package:untitled/models/productModel.dart';
import 'package:untitled/repository/cart_repository.dart';

class CartProvider extends ChangeNotifier{
  List<ProductModel> cartData = [];
  bool isLoading = true;

  Future<List<ProductModel>> getCart()async{
    CartRepository cartRepository = CartRepository();
    cartData = await cartRepository.getCart();
    isLoading = false;
    notifyListeners();
    return cartData;
  }
}