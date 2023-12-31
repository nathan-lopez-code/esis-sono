import "package:esissono/screens/add_screen/sections/bluetooth/blue_scan.dart";
import "package:esissono/screens/add_screen/sections/wifi/wifi_scan.dart";
import "package:flutter/material.dart";
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import "../../../utils/couleur.dart";
import "../../../utils/dimensions.dart";
import "../../../widgets/smalText.dart";


class ASBody extends StatefulWidget {
  const ASBody({Key? key}) : super(key: key);

  @override
  State<ASBody> createState() => _ASBodyState();
}

class _ASBodyState extends State<ASBody> {



  List<Widget> tabList = [
    const BlueScanView(),
    const WifiScanView(),
  ];

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimensions.w05, right: Dimensions.w05),
      margin: EdgeInsets.only(top:Dimensions.h15),
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical:Dimensions.h05, horizontal: Dimensions.w05),
            decoration: BoxDecoration(
                color: Couleur.primaryColor,
                borderRadius: BorderRadius.circular(Dimensions.w05)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallText(text: "Ajouter de nouvel equipement", color: Couleur.secondarColor, size: Dimensions.d15,),
                SizedBox(height: Dimensions.h10,),
                CustomSlidingSegmentedControl<int>(
                  initialValue: 0,
                  children: {
                    0: Row(children: [
                      Icon(Icons.bluetooth, size: Dimensions.d17, color: Couleur.secondarColor,),
                      SizedBox(width: Dimensions.w05,),
                      SmallText(text: "via bluetooth", size: Dimensions.d13,),
                    ],),
                    1: Row(children: [
                        Icon(Icons.wifi, size: Dimensions.d13, color: Couleur.secondarColor,),
                        SizedBox(width: Dimensions.w05,),
                        SmallText(text: "via Wifi", size: Dimensions.d13,),
                        ],),
                  },
                  decoration: BoxDecoration(
                    color: Couleur.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  thumbDecoration: BoxDecoration(
                    color: Couleur.accentColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        blurRadius: 4.0,
                        spreadRadius: 3.0,
                        offset: const Offset(
                          0.0,
                          2.0,
                        ),
                      ),
                    ],
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInToLinear,
                  onValueChanged: (v) {
                    print(v);
                    setState(() {
                      _selectedTab = v;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.h20,),
          Container(
            height: Dimensions.height/ 1.5,
            child: tabList[_selectedTab],
          )
        ],
      ),
    );
  }
}
