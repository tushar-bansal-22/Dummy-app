import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled/providers/cart_provider.dart';
import 'package:untitled/providers/product_provider.dart';
import 'package:untitled/repository/cart_repository.dart';
import 'package:untitled/screens/cart.dart';
import 'package:untitled/screens/product_popup.dart';
import 'package:badges/badges.dart' as badges;

import '../models/productModel.dart';
import '../providers/user.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List<dynamic>> _fetchingData() async {
    var res = await http.get(Uri.http('10.0.2.2:8080', '/products'));
    var decodedResponse = jsonDecode(res.body);
    print(decodedResponse['products'][0]);
    return decodedResponse["products"];
  }

  Future<void> addToCart(ProductModel product) async {
    Provider.of<CartProvider>(context,listen: false).addToCart(product);
  }

  Future<void> addNewProduct(String productId,String productName, String description, String image)async {
    var url = Uri.http('10.0.2.2:8080', '/products');
    ProductModel product = ProductModel(
        int.parse(productId), productName, description, image);
    var res = await http.post(url,
        body: product.toJson());
    var decodedResponse = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
    if (decodedResponse['success'] == true) {
      Provider.of<ProductProvider>(context, listen: false).changedProducts();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (context, user, _) {

            return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.purple.shade200,
            title: Text('Products', style: GoogleFonts.poppins()),
            actions: [
              Container(
                child:  Consumer<CartProvider>(builder: (context, cart, _) {
                      return badges.Badge(
                        showBadge: true,
                        position: badges.BadgePosition.bottomStart(
                            bottom: 0, start: -5),
                        badgeContent: Card(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          child: Text(
                           ' ${cart.cartData.length}',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cart()));
                            },
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.purple.shade200,
                              size: 35,
                              weight: 2,
                            )),
                      );
                    }
                  ,
                ),
              )
            ],

          ),
          body: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          color: Colors.pinkAccent,
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Hey ${user.user.email}!',
                                    style: GoogleFonts.abel(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 24),
                                  ),
                                  Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      color: Colors.white,
                                      child: IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          topRight:
                                                              Radius.circular(
                                                                  30))),
                                              context: context,
                                              builder: (builder) {
                                                return ProductPopup(addNewProduct);
                                              });
                                        },
                                        icon: Icon(Icons.add),
                                        color: Colors.pinkAccent,
                                      ))
                                ],
                              )))),
                  Expanded(
                    flex: 16,
                    child: Consumer<ProductProvider>(
                        builder: (context, productProvider, _) {
                      if (!productProvider.isLoading) {
                        return ListView.builder(
                            itemCount: productProvider.products.length,
                            itemBuilder: (BuildContext context, int index) {
                              ProductModel product =
                                  productProvider.products[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                margin: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                elevation: 10,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 30),
                                  child: Column(
                                    children: [
                                      Image.network(product.image,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                        return Center(child: child);
                                      }),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                product.productName,
                                                style: GoogleFonts.poppins(
                                                    color:
                                                        Colors.purple.shade200,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(product.description),
                                            ],
                                          ),
                                          Card(
                                              color: Colors.pinkAccent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: IconButton(
                                                onPressed: () {
                                                  addToCart(product);
                                                },
                                                icon: Icon(
                                                  Icons
                                                      .add_shopping_cart_outlined,
                                                  color: Colors.white,
                                                ),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
                  ),
                ],
              )


        ),
      );
    });
  }
}
