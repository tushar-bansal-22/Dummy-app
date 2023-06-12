import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/productModel.dart';

class ProductRepository{
  Future<List<ProductModel>> getProducts()async{
    final client = http.Client();
    try {
      final response = await client.get(Uri.http('10.0.2.2:8080', '/products'));
      final data =jsonDecode(response.body);
      final List<ProductModel> products = (data['products'] as List).map((e)=> ProductModel.fromJson(e)).toList();
      return products;
    }  catch (e) {
      return Future.error(e.toString());
    }

  }

}