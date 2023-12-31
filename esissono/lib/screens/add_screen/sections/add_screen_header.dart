import 'package:flutter/material.dart';

import '../../../utils/couleur.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/textApp.dart';
import '../../../widgets/BigText.dart';
import '../../../widgets/smalText.dart';


class ASHeader extends StatelessWidget {
  const   ASHeader({Key? key}) : super(key: key);

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
            padding: EdgeInsets.only(top:Dimensions.h30, bottom: Dimensions.w05, left: Dimensions.w15, right: Dimensions.w15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(text: TextApp.APPNAME, size: Dimensions.d18, color: Couleur.white,),
                SizedBox(height: Dimensions.d05,),
                SmallText(text: TextApp.ASText, color: Couleur.white, size: Dimensions.d12,),
              ],
            ),
          ),

        ],
      ),
    );

  }
}
