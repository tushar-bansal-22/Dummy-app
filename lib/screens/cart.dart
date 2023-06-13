import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled/models/productModel.dart';
import 'package:untitled/providers/cart_provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    // Future<List<dynamic>> getCart() async {
    //   var res = await http.get(Uri.http('10.0.2.2:8080', '/cart'));
    //   var decodedResponse = jsonDecode(res.body);
    //   return (decodedResponse['cartItems']);
    // }
    final cartProvider = context.read<CartProvider>();


        return Scaffold(
          appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.purple.shade200,),onPressed: (){
            Navigator.pop(context);
          },),title: Text('Cart',style: GoogleFonts.poppins(color: Colors.purple.shade200),),backgroundColor: Colors.white,),
          body:
            Consumer<CartProvider>(
              builder: (context,cartProvider,_){
                if (!cartProvider.isLoading) {

                  if(cartProvider.cartData.length==0){
                    return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_shopping_cart_outlined, color: Colors.pinkAccent,size: 200.0,),
                            Text('Cart empty',style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 24),),
                          ],
                        ));
                  }
                  else {
                    return ListView.builder(
                        itemCount: cartProvider.cartData.length,
                        itemBuilder: (BuildContext context, int index) {
                          ProductModel product = cartProvider.cartData[index];
                          return Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: ListTile(
                                leading: Image.network(product.image),
                                title: Text(product.productName,
                                  style: GoogleFonts.poppins(fontSize: 20,
                                      fontWeight: FontWeight.w400),),
                              ),
                            ),
                          );
                        });
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
        );

  }
}
