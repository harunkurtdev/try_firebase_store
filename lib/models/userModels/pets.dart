import 'package:flutter/material.dart';

@immutable
class Pets {
  String? petName;
  String? petYpe;
  int? petAge;

  Pets({this.petName, this.petYpe, this.petAge});

  Pets.fromJson(Map<String, dynamic> json) {
    petName = json['petName'];
    petYpe = json['petYpe'];
    petAge = json['petAge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petName'] = this.petName;
    data['petType'] = this.petYpe;
    data['petAge'] = this.petAge;
    return data;
  }
}