import 'dart:core';
import 'package:esissono/screens/equaliser_screen/equaliser_screen.dart';
import 'package:esissono/screens/main_screen/main_screen.dart';
import 'package:esissono/screens/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class RouterHelper{

  static const String home = "/";
  static const String splash = "/splash";
  static const String equalizer = "/equalizer";


  static String getHome() => home;
  static String getSplash() => splash;
  static String getEqualizer(int index) => "$equalizer?index=$index";

  static List<GetPage> routeList = [

    GetPage(name: home, page: (){
      return MainScreen();
    }),

    GetPage(name: splash, page: (){
      return const SplashScreen();
    }),

    GetPage(
        name: equalizer,
        page:(){
          var index = Get.parameters['index'];
          return EqualizerScreen(index: int.parse(index!));
        }, transition: Transition.fade),

  ];

}