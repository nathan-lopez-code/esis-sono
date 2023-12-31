import "package:esissono/utils/couleur.dart";
import "package:esissono/widgets/BigText.dart";
import "package:esissono/widgets/smalText.dart";
import "package:flutter/material.dart";
import 'package:get/get.dart';
import "../data/local_class.dart";
import "../router/routerHelper.dart";
import "../utils/dimensions.dart";


class GridAuditoire extends StatefulWidget {
  
  
  List<dynamic> listItem; 
  GridAuditoire({Key? key, required this.listItem}) : super(key: key);

  @override
  State<GridAuditoire> createState() => _GridAuditoireState();
}

class _GridAuditoireState extends State<GridAuditoire> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(

        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2,
        crossAxisCount: 2,
       ),
        itemCount: widget.listItem.length,
        itemBuilder: (context, index){

          LocalClass local = widget.listItem[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal : Dimensions.h10),
            height: Dimensions.h200,
            width : Dimensions.w150,
            child: Column(
              children: [
                Container(
                  height: Dimensions.h30,
                  width: Dimensions.w150,
                  decoration:  BoxDecoration(

                    image: DecorationImage(image: AssetImage("assets/images/sono_.jpg"), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.d05), topRight:Radius.circular(Dimensions.d05) )
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouterHelper.getEqualizer(index));
                  },
                  child: Container(

                    decoration : BoxDecoration(
                      color: Couleur.primaryColor,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.d05), bottomRight:Radius.circular(Dimensions.d05) )

                    ),
                    padding: EdgeInsets.all(Dimensions.w05),
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.h05,),
                        BigText(text: local.nomLocal, size: Dimensions.d12, color: Couleur.secondarColor,),
                        SizedBox(height: Dimensions.h05,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                local.typeConnexion=="wifi"?Icon(Icons.wifi, size: Dimensions.d12):Icon(Icons.bluetooth, size: Dimensions.d12),
                                SizedBox(width: 5,),
                                SmallText(text: local.nomDevice, size: Dimensions.d10, )
                              ],
                            ),
                             Row(
                              children: [
                                Icon(Icons.access_time_filled_sharp, size: Dimensions.d10),
                                SizedBox(width: 5,),
                                SmallText(text: "${local.lastConnexion.day}-${local.lastConnexion.month}-${local.lastConnexion.year}", size: Dimensions.d10)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )

              ],
            ),
          );
        },
      );
  }
}
