import 'package:esissono/utils/couleur.dart';
import 'package:esissono/utils/textApp.dart';
import 'package:esissono/widgets/smalText.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/BigText.dart';

class ADSHeader extends StatefulWidget {

  Function callback;
  ADSHeader({Key? key, required this.callback}) : super(key: key);

  @override
  State<ADSHeader> createState() => _ADSHeaderState();
}

class _ADSHeaderState extends State<ADSHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimensions.h100,
      decoration: const BoxDecoration(
        color: Couleur.primaryColor,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(30))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top:Dimensions.h15, bottom: Dimensions.w10, left: Dimensions.w20),
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               BigText(text: TextApp.APPNAME, size: Dimensions.d20, color: Couleur.white,),
               SizedBox(height: Dimensions.d05,),
               SmallText(text: TextApp.asText, color: Couleur.white, size: Dimensions.d12,),
              
             ],
            ),
          ),
     /*     Container(
            margin: EdgeInsets.only(top: Dimensions.h20),
            width: MediaQuery.of(context).size.width/4,
            height: Dimensions.h200,
            decoration:  BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/ADSHeader.jpg", ), fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.h40), topLeft: Radius.circular(Dimensions.d20), bottomLeft: Radius.circular(Dimensions.d20))
            ),
          )*/
        ],
      ),
    );
  }
}
