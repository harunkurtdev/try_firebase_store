
import 'package:flutter/material.dart';

@immutable
class Adress {
  String? street;
  String? city;

  Adress({this.street, this.city});

  Adress.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    return data;
  }
}

