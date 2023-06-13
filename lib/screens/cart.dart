import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/main.dart';
import 'package:untitled/models/productModel.dart';
import 'package:untitled/providers/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Cart extends ConsumerStatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  ConsumerState<Cart> createState() => _CartState();
}

class _CartState extends ConsumerState<Cart> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider)..getCart();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.purple.shade200,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Cart',
            style: GoogleFonts.poppins(color: Colors.purple.shade200),
          ),
          backgroundColor: Colors.white,
        ),
        body: (!cart.isLoading)
            ? ((cart.cartData.isEmpty)
                ? (Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_shopping_cart_outlined,
                        color: Colors.pinkAccent,
                        size: 200.0,
                      ),
                      Text(
                        'Cart empty',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700, fontSize: 24),
                      ),
                    ],
                  )))
                : (ListView.builder(
                    itemCount: cart.cartData.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProductModel product = cart.cartData[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: ListTile(
                            leading: Image.network(product.image),
                            title: Text(
                              product.productName,
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      );
                    })))
            : (CircularProgressIndicator()));
  }
}
