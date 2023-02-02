import 'package:flutter/material.dart';
import 'package:try_firebase_store/models/userModels/adress.dart';
import 'package:try_firebase_store/models/userModels/pets.dart';

@immutable
class User {
  String? name;
  int? age;
  String? email;
  Adress? adress;
  Pets? pets;

  User({this.name, this.age, this.email, this.adress, this.pets});

  User.fromJson(Map<String, dynamic> json) {
    print(json);
    name = json['name'];
    age = json['age'];
    email = json['email'];
    adress =
        json['address'] != null ? new Adress.fromJson(json['address']) : null;
    pets = json['pets'] != null ? new Pets.fromJson(json['pets']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['email'] = this.email;
    if (this.adress != null) {
      data['address'] = this.adress!.toJson();
    }
    if (this.pets != null) {
      data['pets'] = this.pets!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return "user";
  }
}

