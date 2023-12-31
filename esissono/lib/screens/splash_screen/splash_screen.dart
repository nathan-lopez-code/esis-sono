import 'dart:async';
import 'package:esissono/utils/textApp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../router/routerHelper.dart';
import '../../utils/couleur.dart';
import '../../utils/dimensions.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}





class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,
        duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    
    Timer(
      const Duration(seconds: 4),
      ()=>Get.offNamed(RouterHelper.getHome())
    );
  }

  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  double _progress = 90;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: Dimensions.height/1.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             Center(child:CircularSeekBar(
               width: double.infinity,
               height: Dimensions.h300,
               animDurationMillis: 3000,
               progress: _progress,
               barWidth: 8,
               startAngle: 45,
               sweepAngle: 298,
               strokeCap: StrokeCap.butt,
               progressGradientColors: const [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.indigo, Colors.purple],
               innerThumbRadius: 5,
               innerThumbStrokeWidth: 3,
               innerThumbColor: Colors.white,
               outerThumbRadius: 5,
               outerThumbStrokeWidth: 10,
               outerThumbColor: Colors.blueAccent,
               dashWidth: 1,
               dashGap: 2,
               animation: true,
               valueNotifier: _valueNotifier,
               child: Center(
                 child: ScaleTransition(
                     scale: animation,
                     child: Center(child: Image.asset("assets/images/esis_sono_logo.png", width: Dimensions.w250,)))
               ),
             )

             ),

          ],

        ),
      ),
    );
  }
}
