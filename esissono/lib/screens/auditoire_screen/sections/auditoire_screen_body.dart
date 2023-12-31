import 'package:esissono/data/local_class.dart';
import 'package:esissono/utils/textApp.dart';
import 'package:esissono/widgets/BigText.dart';
import 'package:flutter/material.dart';

import '../../../router/routerHelper.dart';
import '../../../utils/constant.dart';
import '../../../utils/couleur.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/gird_view.dart';
import '../../../widgets/smalText.dart';
import 'package:get/get.dart';


class ASDBody extends StatefulWidget {

  Function callback;
  List<dynamic> listLocal;
  ASDBody({Key? key, required this.callback, required  this.listLocal}) : super(key: key);

  @override
  State<ASDBody> createState() => _ASDBodyState();
}

class _ASDBodyState extends State<ASDBody> {

  int selectedIndex = 0;
  bool isSaved = false;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: Dimensions.h10, left: Dimensions.w05, right: Dimensions.w05),
      child: Column(
        children: [
            widget.listLocal.isNotEmpty?GridAuditoire(listItem: widget.listLocal):Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical:Dimensions.h05, horizontal: Dimensions.w05),
                  decoration: BoxDecoration(
                      color: Couleur.primaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.w05)
                  ),
                  child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(text: "Les appareils enregistres s'affiche ici, vous venez d'enregister ? actualisez", color: Couleur.secondarColor, size: Dimensions.d15,),
                        GestureDetector(

                            onTap: (){
                              Get.toNamed(RouterHelper.getHome());
                            },
                            child: Icon(Icons.refresh, color: Couleur.secondarColor, size: Dimensions.d17,))
                      ],
                  ),
                ),
                SizedBox(height: Dimensions.h50,),
                SingleChildScrollView(
                    child: isSaved?const Column(

                    ):Column(crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Container(
                          height: Dimensions.h200,
                          width: Dimensions.w250,
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.w20),
                              image: const DecorationImage(
                                  image:AssetImage("assets/images/no_saved.jpg"), fit: BoxFit.cover
                              )
                          ),
                        ),
                        SizedBox(height: Dimensions.h30,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BigText(text: TextApp.textHSBody, size: Dimensions.d15, color: Couleur.primaryColor,),
                            SizedBox(height: Dimensions.d10,),
                            SizedBox(
                                width: Dimensions.w300,
                                child: SmallText(text: TextApp.text2HSBody, size: Dimensions.d15, color: Couleur.primaryColor,)),
                            SizedBox(height: Dimensions.h20,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  widget.callback(Constants.ajoutAuditoireID);
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.lightBlue),
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width/1.5,
                                child: Center(
                                  child: Row(
                                    children: [
                                      const Icon(Icons.add_circle, color: Couleur.secondarColor,),
                                      SizedBox(width: Dimensions.w05,),
                                      BigText(text: TextApp.add, size: Dimensions.d15, color: Couleur.secondarColor,)
                                    ],
                                  ),
                                ),
                              ),

                            )
                          ],
                        )
                      ],
                    )
                )
              ],
            )
        ],
      ),
    );
  }
}
