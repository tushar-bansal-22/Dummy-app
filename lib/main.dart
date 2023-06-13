import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/providers/cart_provider.dart';
import 'package:untitled/providers/product_provider.dart';
import 'package:untitled/providers/user.dart';
import 'package:untitled/screens/cart.dart';
import 'package:untitled/screens/dashboard.dart';
import 'package:untitled/screens/login.dart';


void main() {
  runApp(
    MyApp()
  );

}


final userProvider = ChangeNotifierProvider<User>((ref) => User());
final productProvider = ChangeNotifierProvider<ProductProvider>((ref) => ProductProvider());
final cartProvider = ChangeNotifierProvider<CartProvider>((ref) => CartProvider());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: Login(),
      ),
    );
  }
}

