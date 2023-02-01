
import 'package:flutter/material.dart';
import 'package:try_firebase_store/models/userModels/usersModel.dart';

@immutable
class model {
  User? keyToken;

  model({this.keyToken});

  model.fromJson(Map<String, dynamic> json) {
    keyToken = json['key_token'] != null
        ? new User.fromJson(json['key_token'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.keyToken != null) {
      data['key_token'] = this.keyToken!.toJson();
    }
    return data;
  }
}
