import 'dart:convert';

import 'package:flutter/cupertino.dart';

class UserModel{
    late String email;
    late String password;

    UserModel(this.email, this.password);


    toJson(){
        return jsonEncode({"email": email, "password": password});
    }
}