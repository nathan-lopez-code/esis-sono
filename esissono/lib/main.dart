import 'package:esissono/router/routerHelper.dart';
import 'package:esissono/screens/splash_screen/splash_screen.dart';
import 'package:esissono/utils/dimensions.dart';
import 'package:esissono/utils/textApp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:equalizer_flutter_custom/src/EqalizerProvider/EqualizerProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Provider.debugCheckInvalidValueType = null;
  // Must add this line.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  ChangeNotifierProvider(
        create: (context) => EqualizerProvider(),
        child :GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: RouterHelper.routeList,
          initialRoute: RouterHelper.getSplash(),
          title: TextApp.APPNAME,
     /*     home:SplashScreen()*/
        )
    );

  }
}
