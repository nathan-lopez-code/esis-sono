import 'dart:io';

import 'package:hive/hive.dart';


part 'local_class.g.dart';



@HiveType(typeId: 1)
class LocalClass extends HiveObject {

  LocalClass({
    required this.nomLocal,
    required this.typeConnexion,
    required this.nomDevice,
    required this.passwordDevice,
    required this.lastConnexion
  });


  @HiveField(0)
  String nomLocal;

  @HiveField(1)
  String typeConnexion;

  @HiveField(2)
  String nomDevice;

  @HiveField(3)
  String passwordDevice;

  @HiveField(4)
  DateTime lastConnexion;


  String getPassword(){
    return passwordDevice;
  }


}






