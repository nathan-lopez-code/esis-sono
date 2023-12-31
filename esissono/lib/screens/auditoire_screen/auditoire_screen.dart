import 'package:esissono/data/local_class.dart';
import 'package:esissono/screens/auditoire_screen/sections/Auditoire_screen_header.dart';
import 'package:esissono/screens/auditoire_screen/sections/auditoire_screen_body.dart';
import 'package:flutter/material.dart';



class AuditoireScreen extends StatefulWidget {

  Function callback;
  List<dynamic> listLocal;
  AuditoireScreen({Key? key, required this.callback, required this.listLocal}) : super(key: key);

  @override
  State<AuditoireScreen> createState() => _AuditoireScreenState();
}

class _AuditoireScreenState extends State<AuditoireScreen> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ADSHeader(callback: widget.callback, ),
              ASDBody(callback: widget.callback, listLocal : widget.listLocal)
            ],
          ),

    );
  }
}
