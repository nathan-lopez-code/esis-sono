import 'package:flutter/cupertino.dart';
import '../utils/couleur.dart';
import '../utils/dimensions.dart';

class BigText extends StatelessWidget {

  final String text;
  double size;
  Color color;

  BigText({Key? key,
    required this.text,
    this.size = 0,
    this.color = Couleur.white

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      style: TextStyle(
      color: color==Couleur.white?color:color,
      fontSize: size==0?Dimensions.d25:size,
      fontWeight: FontWeight.w600,
      fontFamily: "sans-serif",
      overflow: TextOverflow.ellipsis

    ),
    );
  }
}
