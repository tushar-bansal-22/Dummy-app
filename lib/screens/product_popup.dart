import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/main.dart';
import 'package:untitled/models/productModel.dart';
import 'package:untitled/providers/product_provider.dart';
import 'package:untitled/screens/dashboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductPopup extends ConsumerStatefulWidget {
  BuildContext cntxt ;
  ProductPopup(this.cntxt);
  @override
  ConsumerState<ProductPopup> createState() => _ProductPopupState();
}

class _ProductPopupState extends ConsumerState<ProductPopup> {
  TextEditingController productName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController productId = TextEditingController();

  Future<void> addProduct(ProductProvider productProvider) async{
    var url=Uri.http('10.0.2.2:8080','/products');
    ProductModel product = ProductModel(int.parse(productId.text), productName.text, description.text, image.text);
    var res = await http.post(url,
        body:product.toJson());
    var decodedResponse = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
    if(decodedResponse['success']==true) {
      productProvider.changedProducts();
      Navigator.pop(context);
      // Navigator.pop(context);
    };
  }

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productProvider);
    return Padding(
      padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft:Radius.circular(30), topRight: Radius.circular(30) )
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
          children: [
            Card(

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: TextFormField(
                  decoration: InputDecoration(hintText:'Product ID',border: InputBorder.none ),
                  keyboardType: TextInputType.number,
                  controller: productId,
                ),
              ),
            ),
            Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: TextFormField(
                  decoration: InputDecoration(hintText:'Product Name',border: InputBorder.none ),
                  controller: productName,
                ),
              ),
            ),
            Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: TextFormField(
                  decoration: InputDecoration(hintText:'Image URL',border: InputBorder.none ),
                  controller: image,
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: TextFormField(
                  decoration: InputDecoration(hintText:'Description',border: InputBorder.none ),
                  controller: description,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                        child: ElevatedButton(onPressed: (){addProduct(product);}, child: Text('Add Product'),style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 5),backgroundColor: Colors.pinkAccent,foregroundColor: Colors.white),))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
