

import 'dart:convert';

class ProductModel{
  late int productId;
  late String productName;
  late String image;
  late String description;

  ProductModel(this.productId,this.productName,this.description,this.image);

  toJson(){
    return jsonEncode({"productId":productId,"productName":productName,"image":image,"description":description});
  }

  ProductModel.fromJson(Map<String,dynamic> decodedData){
    // var decodedData = jsonDecode(data);
    productId = decodedData['productId'];
    productName = decodedData['productName'];
    image = decodedData['image'];
    description = decodedData['description'];
  }

  toCartJson(){
    return jsonEncode({"productId":productId});
  }


}