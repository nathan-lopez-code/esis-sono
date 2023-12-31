import 'package:esissono/utils/couleur.dart';
import 'package:esissono/utils/textApp.dart';
import 'package:esissono/widgets/smalText.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/BigText.dart';

class HSHeader extends StatefulWidget {

  Function callback;
  HSHeader({Key? key, required this.callback}) : super(key: key);

  @override
  State<HSHeader> createState() => _HSHeaderState();
}

class _HSHeaderState extends State<HSHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimensions.h130,
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
               SmallText(text: TextApp.description, color: Couleur.white, size: Dimensions.d12,),
               SizedBox(height: Dimensions.h20,),
               ElevatedButton(
                  onPressed: (){
                    setState(() {
                      widget.callback(Constants.ajoutAuditoireID);
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Couleur.accentColor),
                  ),
                   child: Row(
                     children: [
                       const Icon(Icons.add_circle, color: Couleur.secondarColor,),
                       SizedBox(width: Dimensions.w05,),
                       BigText(text: "Ajouter equipement", size: Dimensions.d12, color: Couleur.secondarColor,)
                     ],
                   ),

               ),
             ],
            ),
          ),
     /*     Container(
            margin: EdgeInsets.only(top: Dimensions.h20),
            width: MediaQuery.of(context).size.width/4,
            height: Dimensions.h200,
            decoration:  BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/HSHeader.jpg", ), fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.h40), topLeft: Radius.circular(Dimensions.d20), bottomLeft: Radius.circular(Dimensions.d20))
            ),
          )*/
        ],
      ),
    );
  }
}
