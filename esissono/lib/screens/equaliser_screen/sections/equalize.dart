import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../utils/couleur.dart';
import '../../../utils/dimensions.dart';

import 'myCustom_eq.dart';

class Equalize extends StatefulWidget {

  final player;
  Equalize({Key? key, required this.player}) : super(key: key);

  @override
  State<Equalize> createState() => _EqualizeState();
}

class _EqualizeState extends State<Equalize> {

  bool enableCustomEQ = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.h15),
      height: Dimensions.height,
      width: Dimensions.width,
      child: widget.player==null?Center(
          child: SpinKitCircle(
            color: Couleur.primaryColor,
            size: Dimensions.h50,
          ),
        ):MyCustomEqualizerer(

            isEqEnabled: true, //Enable Equalizer
            playerSessionId: widget.player.androidAudioSessionId!,// Most Important AudioSessionId NOT NULL
            bandTextColor: Couleur.secondarColor,
            sliderBoxHeight: Dimensions.h200,
            sliderBoxPadding: Dimensions.w20,
            sliderBoxBorderRadius: BorderRadius.circular(Dimensions.w10),
            appBarLeading: Container(),
            appBarTitle: "Faite vos reglage de son ici",
            baseTextColor: Couleur.secondarColor,
            appBarBgColor: Couleur.primaryColor,
            bgColor: Couleur.primaryColor,
            sliderBoxBackgroundColor: Colors.black,
          ),
    );
  }
}
