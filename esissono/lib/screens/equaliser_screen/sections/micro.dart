import 'package:esissono/widgets/BigText.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/couleur.dart';
import '../../../utils/dimensions.dart';

import 'package:equalizer_flutter_custom/src/EqalizerProvider/EqualizerProvider.dart';
import 'package:equalizer_flutter_custom/src/CustomSlider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'micro_provider.dart';

class MicroScreen extends StatefulWidget {
  const MicroScreen({Key? key}) : super(key: key);

  @override
  State<MicroScreen> createState() => _MicroScreenState();
}

class _MicroScreenState extends State<MicroScreen> {


  final slider = SleekCircularSlider(
      appearance: CircularSliderAppearance(
          customColors: CustomSliderColors(
            dotColor: Couleur.primaryColor,
            dynamicGradient: true,
            progressBarColor: Couleur.primaryColor,
            trackColor: Couleur.secondarColor,
            hideShadow: true,

          )),
      onChange: (double value) {
        print(value);
      });


  final slider2 = SleekCircularSlider(
      appearance: CircularSliderAppearance(
          customColors: CustomSliderColors(
          dotColor: Couleur.primaryColor,
            dynamicGradient: true,
            progressBarColor: Couleur.primaryColor,
            trackColor: Couleur.secondarColor,
            hideShadow: true,

          )),
      onChange: (double value) {
        print(value);
      });


  @override
  Widget build(BuildContext context) {
    return Padding(

      padding:  EdgeInsets.only(top:Dimensions.h20),
      child: Column(
        children: [
          Container(
            height: Dimensions.h40,
            width: Dimensions.width,
            margin: EdgeInsets.only(bottom: Dimensions.h10),
            decoration: BoxDecoration(
              color: Couleur.primaryColor,
              boxShadow: const  [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 5),
                  blurRadius: 2,
                  spreadRadius: 1
                )
              ],
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.w05), bottomLeft: Radius.circular(Dimensions.w05))
            ),
            child: Center(
                child: BigText(text: "Gerer vos micros ici", color: Couleur.secondarColor, size: Dimensions.d17)

            ),
          ),
          Container(
            color: Couleur.secondarColor,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: Dimensions.w10, right: Dimensions.w10, top: Dimensions.h10, bottom: Dimensions.h10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    slider,
                    Text(
                        "Echo",
                        style: TextStyle(
                          fontSize: Dimensions.d17,
                          color: Couleur.primaryColor,

                        )
                    )
                  ],
                ),
                Column(
                  children: [
                    slider2,
                    Text(
                        "Volume",
                        style: TextStyle(
                          fontSize: Dimensions.d17,
                          color: Couleur.primaryColor,

                        )
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



/*
final sk = SleekCircularSlider(
  min: 0,
  max: 1000,
  initialValue: context.watch<MicroController>().controller1,
  onChangeEnd: (val) {
    context.watch<MicroController>().setController1(val);
  },
  appearance: CircularSliderAppearance(
      customColors: CustomSliderColors(
        dotColor: Couleur.primaryColor,
        dynamicGradient: true,
        progressBarColor: Couleur.primaryColor,
        trackColor: Couleur.secondarColor,
        hideShadow: true,

      )),
);*/
