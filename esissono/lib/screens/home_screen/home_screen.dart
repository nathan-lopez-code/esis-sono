import 'package:esissono/data/local_class.dart';
import 'package:esissono/screens/home_screen/sections/home_screen_body.dart';
import 'package:esissono/screens/home_screen/sections/home_screen_header.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {

  Function callback;
  List<dynamic> listLocal;
  HomeScreen({Key? key, required this.callback, required this.listLocal}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HSHeader(callback: widget.callback,),
              HSBody(callback: widget.callback, listLocal: widget.listLocal)
            ],
          ),

    );
  }
}
