import 'package:flutter/material.dart';

class GlobalKeyHelper {
  static final GlobalKeyHelper  _prefInstance =GlobalKeyHelper._init();
  late final GlobalKey<FormState> _formKey;

  static GlobalKeyHelper get prefInstance => _prefInstance;

  GlobalKeyHelper._init(){
    _formKey= GlobalKey<FormState>();
  }

  GlobalKey<FormState> get fromkey=>_formKey;
  
}

// void main(List<String> args) {
//   GlobalKeyHelper.prefInstance.fromkey;
// }