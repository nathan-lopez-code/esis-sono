import 'dart:async';
import 'package:flutter/services.dart';
import 'package:esissono/screens/add_screen/sections/bluetooth/List_view.dart';
import 'package:esissono/widgets/smalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/foundation.dart';
import '../../../../utils/couleur.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/textApp.dart';
import '../../../../widgets/BigText.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';






class BlueScanView extends StatefulWidget {
  const BlueScanView({Key? key}) : super(key: key);

  @override
  State<BlueScanView> createState() => _BlueScanViewState();
}

class _BlueScanViewState extends State<BlueScanView> {


 // final WifiScanDesktop _wifiScanDesktopPlugin = WifiScanDesktop();

  bool isLoaded = false;
  bool isSearching = false;
  bool listVisible = false;

  bool shouldCheckCan = true;
  List<BluetoothDevice> listBluetooth  = [];
  List<BluetoothDevice> seen  = [];


  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    super.initState();
    _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return isSearching?Container(
      child: listBluetooth.isNotEmpty?SingleChildScrollView(child: ListNetwork(listBlue: listBluetooth)):SizedBox(
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
          SmallText(text: TextApp.BlueTextScan,size: Dimensions.d15, color: Couleur.primaryColor,),
          SizedBox(height: Dimensions.h10,),
          SizedBox(
            width: Dimensions.w250,
            child: ElevatedButton(
              onPressed: ()  async {

                setState(() {
                  isSearching = true;
                  listBluetooth = [];
                });

                Set<DeviceIdentifier> seen = {};
                var subscription = FlutterBluePlus.scanResults.listen(
                (results) {
                for (ScanResult r in results) {
                  if (seen.contains(r.device.remoteId) == false) {
                    print('${r.device.remoteId}: "${r.advertisementData.localName}" found! rssi: ${r.rssi}');
                    seen.add(r.device.remoteId);
                    }
                  }
                },
                onError: (e) => print("erreur: $e")
                );

                await FlutterBluePlus.startScan();

                Timer(Duration(seconds: 10), () {

                if (isSearching) {
                  if (listBluetooth.isNotEmpty){
                  setState(() {
                     isSearching = false;
                  });
                  }else{
                  setState(() {
                    isSearching = false;
                  });
                   kShowSnackBar(context, "Auncun reseau trouver");
                  }
                }
                });


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
        ]
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


