import 'package:flutter/material.dart';

class MicroController extends ChangeNotifier{

  double controller1 = 50;
  double controller2 = 50;

  setController1(double val){
    controller1 = val;
    notifyListeners();
  }

  setController2(double val){
    controller2 = val;
    notifyListeners();
  }


}
