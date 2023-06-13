
import 'package:flutter/material.dart';
import 'package:untitled/providers/cart_provider.dart';
import 'package:untitled/providers/product_provider.dart';
import 'package:untitled/providers/user.dart';
import 'package:untitled/screens/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_)=>User(),),ChangeNotifierProvider(create: (_)=>ProductProvider()..getProducts(),),ChangeNotifierProvider(
  create: (context)=>CartProvider()..getCart())],
    child: const MyApp(),)
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
    );
  }
}

