import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/userModel.dart';
import '../screens/dashboard.dart';
import 'package:http/http.dart' as http;

class User extends ChangeNotifier{
  late UserModel user;
  var url=Uri.http('10.0.2.2:8080','/login');

  void login(BuildContext context, UserModel user) async{
    this.user=user;
    var res = await http.post(url,
        body:user.toJson());
    var decodedResponse = jsonDecode(res.body) as Map;
    if(decodedResponse['success']==true){
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>Dashboard()),(Route<dynamic> route) => false);
    };

    // notifyListeners();
  }



}