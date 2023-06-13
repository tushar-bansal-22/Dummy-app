import 'dart:convert';
import 'dart:core';

import 'package:untitled/models/productModel.dart';
import 'package:http/http.dart' as http;

class CartRepository{
  Future<List<ProductModel>> getCart()async{
    final client = http.Client();
    try {
      final respone = await client.get(Uri.http('10.0.2.2:8080', '/cart'));
      final data =jsonDecode(respone.body);
      final List<ProductModel> products = (data['cartItems'] as List).map((e)=> ProductModel.fromJson(e)).toList();
      return products;
    }  catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> addProductToCart(String product) async{
    await http.post(Uri.http('10.0.2.2:8080', '/cart'),
        body: product);
  }
}