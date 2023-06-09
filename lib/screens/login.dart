import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled/screens/dashboard.dart';

import '../models/userModel.dart';
import '../providers/user.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.purple.shade200,
        title: Text('Login',style:GoogleFonts.poppins()),
      ),
      body: !isLoading ?Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextField(
              controller: email,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextField(
              obscureText: true,
              controller: password,
            ),
          ),
          SizedBox(height: 40,),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade200
                    ),
                      onPressed: () async{
                      setState(() {
                        isLoading=true;
                      });
                    Provider.of<User>(context, listen: false).login(
                  context,
                    UserModel(email.text,
                    password.text));
                  }, child: Text('Login')),

                ),
              ),
            ],
          ),

        ],
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}
