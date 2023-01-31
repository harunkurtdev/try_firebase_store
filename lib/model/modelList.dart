

import 'dart:ffi';



mixin AppSize{
  static int Height=812;
  static int Width=375;
  void functionM(){
    print("m");
  }
}

enum enumAppSize{
    open(110),
  confirmed(20),
  completed(30),
  cancelled(40);

  final int progress;
  const enumAppSize(this.progress);

}

class singleTonAppSize{

  static final singleTonAppSize _instance = singleTonAppSize._();
  singleTonAppSize._();

  factory singleTonAppSize.instance(){
    return _instance;
  }

  void functionZ(){
    print("z");
  }

}


abstract class Model  {
  late List _size;

  Model(){
    _size = [];
  }


  void functionX(){
    print(" merhaba sude");
  }



  List calculateArea(double x,double y){
    
  
  AppSize.Height;
    return _size;
  }
}

class modelList extends Model {
  
  modelList({required List size}){
    this._size=size;
  }
  
  @override
  void functionX() {
    // TODO: implement functionX
  AppSize.Height;
  singleTonAppSize.instance().functionZ();
  }
}