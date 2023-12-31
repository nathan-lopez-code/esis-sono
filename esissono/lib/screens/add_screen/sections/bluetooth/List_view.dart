import "dart:async";
import "package:esissono/widgets/BigText.dart";
import "package:esissono/widgets/smalText.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
//import 'package:wifi_scan_desktop/wifi_info.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import "../../../../utils/couleur.dart";
import "../../../../utils/dimensions.dart";
import "../../../../utils/textApp.dart";
import 'package:wifi_scan/wifi_scan.dart';
import 'package:flutter_iot_wifi/flutter_iot_wifi.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';


class ListNetwork extends StatefulWidget {

  List<dynamic> listBlue = [];


  ListNetwork({Key? key, required this.listBlue}) : super(key: key);

  @override
  State<ListNetwork> createState() => _ListNetworkState();
}

class _ListNetworkState extends State<ListNetwork> {
  bool isConnected = false;
  bool tryConnecting = false;
  bool connecting = false;

  final TextEditingController controllerEditAuditoire = TextEditingController();
  final TextEditingController controllerEditPassword = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        BigText(text: "le resultat s'affiche ici ", size: Dimensions.d15, color: Couleur.primaryColor,),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: widget.listBlue.length,
          itemBuilder : (context, index){

            BluetoothDevice device = widget.listBlue[index];
            return Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.w05, horizontal: Dimensions.h05),
              margin: EdgeInsets.symmetric(vertical: Dimensions.h05),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.d05),
                  color: Couleur.primaryColor
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bluetooth_audio, color: Couleur.secondarColor, size: Dimensions.d13,),
                      SizedBox(width: Dimensions.w05),
                      BigText(text: device.platformName, size: Dimensions.d13,),
                    ],
                  ),
                  ElevatedButton(

                    onPressed: (){
                      showPopupWindow(
                        context,
                        gravity: KumiPopupGravity.center,
                        //curve: Curves.elasticOut,
                        bgColor: Colors.white.withOpacity(0.8),
                        clickOutDismiss: true,
                        clickBackDismiss: true,
                        customAnimation: false,
                        customPop: false,
                        customPage: false,
                        //targetRenderBox: (btnKey.currentContext.findRenderObject() as RenderBox),
                        //needSafeDisplay: true,
                        underStatusBar: false,
                        underAppBar: true,
                        offsetX: 0,
                        offsetY: 0,
                        duration: Duration(milliseconds: 200),
                        onShowStart: (pop) {
                          print("showStart");
                        },
                        onShowFinish: (pop) {
                          print("showFinish");
                        },
                        onDismissStart: (pop) {
                          print("dismissStart");
                        },
                        onDismissFinish: (pop) {
                          print("dismissFinish");
                        },
                        onClickOut: (pop){
                          print("onClickOut");
                        },
                        onClickBack: (pop){
                          print("onClickBack");
                        },
                        childFun: (pop) {
                          return Container(
                            key: GlobalKey(),
                            padding: EdgeInsets.symmetric(vertical:Dimensions.h15, horizontal: Dimensions.w15),
                            height: MediaQuery.of(context).size.height/2.1,
                            width: MediaQuery.of(context).size.width/1.2,
                            color: Couleur.primaryColor,
                            child: Column(
                              children: [
                                SmallText(text: "Configuration pour ${widget.listBlue[index].name}"),
                                SizedBox(height: Dimensions.h20,),
                                TextField(
                                  controller: controllerEditAuditoire,
                                  style: TextStyle(
                                    color: Couleur.primaryColor,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400,
                                    fontSize: Dimensions.d15,
                                  ),
                                  autofocus: true,
                                  decoration: InputDecoration(

                                      border: InputBorder.none,
                                      hintText: "Nom de l'auditoire",
                                      fillColor: Couleur.secondarColor,
                                      hintStyle: TextStyle(
                                        color: Couleur.primaryColor,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w400,
                                        fontSize: Dimensions.d15,
                                      ),
                                      filled: true,


                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    // Connect to the device
                                    //await device.connect(autoConnect: true);
                                    Timer(Duration(seconds: 36), (){

                                      kShowSnackBar(context, "connection etablie");
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.lightBlue),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(text: TextApp.saved, size: Dimensions.d13, color: Couleur.secondarColor,)
                                    ],
                                  ),
                                  ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => Couleur.accentColor),
                    ),
                    child: BigText(text: "se connecter", size: Dimensions.d15, color: Couleur.secondarColor,),
                  ),
                ],
              ),
            );
            },

        ),
      ],
    );
  }
}


/// Show snackbar.
void kShowSnackBar(BuildContext context, String message) {
  if (kDebugMode) print(message);
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
