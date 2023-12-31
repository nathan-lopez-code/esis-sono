import 'package:esissono/screens/add_screen/sections/add_screen_body.dart';
import 'package:esissono/screens/add_screen/sections/add_screen_header.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ASHeader(),
        Expanded(child: ASBody())
      ],
    );
  }
}
