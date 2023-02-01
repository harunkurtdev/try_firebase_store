import 'package:flutter/material.dart';

@immutable
class Pets {
  String? petName;
  String? petYpe;
  int? petAge;

  Pets({this.petName, this.petYpe, this.petAge});

  Pets.fromJson(Map<String, dynamic> json) {
    petName = json['pet_name'];
    petYpe = json['petYpe'];
    petAge = json['petAge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pet_name'] = this.petName;
    data['petYpe'] = this.petYpe;
    data['petAge'] = this.petAge;
    return data;
  }
}