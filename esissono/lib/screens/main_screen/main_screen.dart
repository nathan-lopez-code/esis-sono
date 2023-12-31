import 'dart:async';
import 'dart:io';
import 'package:esissono/data/local_class.dart';
import 'package:esissono/screens/add_screen/add_screen.dart';
import 'package:esissono/screens/home_screen/home_screen.dart';
import 'package:esissono/utils/couleur.dart';
import 'package:esissono/utils/textApp.dart';
import 'package:esissono/widgets/BigText.dart';
import 'package:esissono/widgets/smalText.dart';
import "package:flutter/material.dart";
import 'package:side_navigation/side_navigation.dart';
import 'package:hive/hive.dart';
import '../../utils/dimensions.dart';
import '../auditoire_screen/auditoire_screen.dart';
import '../../data/local_class.dart';
import 'package:get/get.dart';


class MainScreen extends StatefulWidget {


  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  int selectedIndex = 0;
  bool isLoading = true;
  var boxLocal ;
  var boxWifi;
  List<dynamic> listLocal = [];

  List<String> wifiNameList = [
    "Cmix 44:5P",
    "X0FKD ee-er",
    "Headphone",
    "Cmix ff:51",
    "Cmixv3",
    "wifi HeadPhone",
    "ZImdac 32",
  ];

  Future<void> _init() async {
    // Open the box where the data is stored.
    Hive.registerAdapter(LocalClassAdapter());
    boxLocal = await Hive.openBox('local');
    boxWifi = await Hive.openBox('wifi');


    var listWifi = boxWifi.get("listWifi");
    if (listWifi == null){
      boxWifi.put("listWifi", wifiNameList);
    }

    try{
      listLocal = boxLocal.get("listLocal");
      print(listLocal.length);
    } catch(E){
      print(E);
      listLocal = [];

    }
  }

  callback(newSeletedIndex){
    setState(() {
      selectedIndex = newSeletedIndex;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);

  }



  @override
  Widget build(BuildContext context) {
    /// Views to display
    List<Widget> views =  [
      HomeScreen(callback: callback, listLocal: listLocal),
      AuditoireScreen(callback: callback,listLocal: listLocal),
      const AddScreen(),
    ];


    Timer(
        const Duration(seconds: 4), (){
        setState(() {
          isLoading = false;
        });

    });


    return Scaffold(

      body: Padding(
        padding: EdgeInsets.only(top: Dimensions.h30),
        child: Row(
          children: [
            SideNavigationBar(
              initiallyExpanded: false,
              expandable: true,
              header: SideNavigationBarHeader(
                  image: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(image:AssetImage("assets/images/esis_sono_logo.png"))
                      ),
                    ),
                  ),
                  title:  BigText(text: "ESIS SONO"),
                  subtitle: const SmallText(text: "")
              ),
/*            footer: const SideNavigationBarFooter(
                  label: Text('Footer label', style: TextStyle(
                    color: Colors.white
                  ),)
              ),*/
              selectedIndex: selectedIndex,
              items:  [
                SideNavigationBarItem(
                  icon: Icons.dashboard,
                  label: TextApp.itemNavigation[0],
                ),
                SideNavigationBarItem(
                  icon: Icons.manage_search,
                  label:  TextApp.itemNavigation[1],
                ),
                SideNavigationBarItem(
                  icon: Icons.settings,
                  label: TextApp.itemNavigation[2],
                ),
              ],
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              theme: SideNavigationBarTheme(
                backgroundColor: Couleur.primaryColor,
                togglerTheme: const SideNavigationBarTogglerTheme(expandIconColor: Color.fromARGB(0, 0, 0, 0), shrinkIconColor:Color.fromRGBO(0, 0, 0, 0)),
                itemTheme: SideNavigationBarItemTheme.standard(),
                dividerTheme: SideNavigationBarDividerTheme.standard(),
              ),
            ),
            /// Make it take the rest of the available width
            AnimatedContainer(duration: Duration(seconds: 3)),
            SizedBox(
              width: Dimensions.width - Dimensions.w51,
              child: isLoading?Center(child: CircularProgressIndicator(),):views.elementAt(selectedIndex),
            )
          ],
        ),
      ),
    );
  }
}
