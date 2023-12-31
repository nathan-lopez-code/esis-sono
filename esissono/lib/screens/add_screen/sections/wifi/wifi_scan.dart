import 'dart:async';

import 'package:esissono/screens/add_screen/sections/wifi/List_view.dart';
import 'package:esissono/widgets/smalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
/*
import 'package:wifi_scan_desktop/wifi_info.dart';
import 'package:wifi_scan_desktop/wifi_scan_desktop.dart';
*/
import 'package:flutter/foundation.dart';
import 'package:wifi_scan/wifi_scan.dart';
import '../../../../utils/couleur.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/textApp.dart';
import '../../../../widgets/BigText.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';




class WifiScanView extends StatefulWidget {
  const WifiScanView({Key? key}) : super(key: key);

  @override
  State<WifiScanView> createState() => _WifiScanViewState();
}

class _WifiScanViewState extends State<WifiScanView> {


 // final WifiScanDesktop _wifiScanDesktopPlugin = WifiScanDesktop();

  bool isLoaded = false;
  bool isSearching = false;
  bool listVisible = false;

  List<String> listWifi =[];
  StreamSubscription<List<WiFiAccessPoint>>? subscription;
  bool shouldCheckCan = true;

  bool get isStreaming => subscription != null;
  var box;

  Future<void> _startScan() async {

    box = await Hive.openBox('wifi');

    var listWifi = box.get("listWifi");

    setState(() => this.listWifi = listWifi);
 }

 // Future<bool> _canGetScannedResults(BuildContext context) async {
 /*   if (shouldCheckCan) {
      final can = await WiFiScan.instance.canGetScannedResults();
      if (can != CanGetScannedResults.yes) {
        if (mounted) kShowSnackBar(context, "Cannot get scanned results: $can");
        listWifi = <WiFiAccessPoint>[];
        return false;
      }
    }
    return true*//*   if (shouldCheckCan) {
      // check if can-startScan
      final can = await WiFiScan.instance.canStartScan();
      // if can-not, then show error
      if (can != CanStartScan.yes) {
        if (mounted) kShowSnackBar(context, "Cannot start scan: $can");
        return;
      }*/
  //}

/*
  Future<void> _getScannedResults(BuildContext context) async {
    if (await _canGetScannedResults(context)) {
      // get scanned results
      final results = await WiFiScan.instance.getScannedResults();
      setState(() => listWifi = results);
    }
  }

  Future<void> _startListeningToScanResults(BuildContext context) async {
    if (await _canGetScannedResults(context)) {
      subscription = WiFiScan.instance.onScannedResultsAvailable
          .listen((result) => setState(() => listWifi = result));
    }
  }

  void _stopListeningToScanResults() {
    subscription?.cancel();
    setState(() => subscription = null);
  }
*/

  @override
  void dispose() {
    super.dispose();
    // stop subscription for scanned results
   // _stopListeningToScanResults();
  }


  @override
  Widget build(BuildContext context) {
    return isSearching?Container(
      child: listWifi.isNotEmpty?ListNetwork(listWifi: listWifi):SizedBox(
        height: Dimensions.h200,
        child: Center(
          child: SpinKitCircle(
            color: Couleur.primaryColor,
            size: Dimensions.h50,
          ),
        ),
      ),
    ):Column(
          children: [
            SizedBox(height: Dimensions.h15,),
            SmallText(text: TextApp.wifiTextScan,size: Dimensions.d15, color: Couleur.primaryColor,),
            SizedBox(height: Dimensions.h10,),
            SizedBox(
              width: Dimensions.w250,
              child: ElevatedButton(
                onPressed: () async {

                 // List<dynamic>? result = await _wifiScanDesktopPlugin.getAvailableNetworks();
                  setState(() {
                    isSearching = true;
                  });
                  //_startScan(context);

                  Timer(
                      const Duration(seconds: 3),(){
                    //_getScannedResults(context);
                    _startScan();

                  }

                  );

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.lightBlue),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.search, color: Couleur.secondarColor,),
                    SizedBox(width: Dimensions.w05,),
                    BigText(text: TextApp.add, size: Dimensions.d17, color: Couleur.secondarColor,)
                  ],
                ),
              ),
            )
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