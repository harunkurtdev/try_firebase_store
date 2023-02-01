import 'package:try_firebase_store/models/userModels/adress.dart';
import 'package:try_firebase_store/models/userModels/pets.dart';

class User {
  String? name;
  int? age;
  String? email;
  Adress? adress;
  Pets? pets;

  User({this.name, this.age, this.email, this.adress, this.pets});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    email = json['email'];
    adress =
        json['adress'] != null ? new Adress.fromJson(json['adress']) : null;
    pets = json['pets'] != null ? new Pets.fromJson(json['pets']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['email'] = this.email;
    if (this.adress != null) {
      data['adress'] = this.adress!.toJson();
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
