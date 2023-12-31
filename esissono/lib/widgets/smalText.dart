import 'package:flutter/cupertino.dart';
import '../utils/couleur.dart';
import '../utils/dimensions.dart';

class SmallText extends StatelessWidget {

  final String text;
  final double size;
  final Color color;

  const SmallText({Key? key,
    required this.text,
    this.size = 0,
    this.color = Couleur.white

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color==Couleur.white?color:color,
        fontSize: size==0?Dimensions.d18:size,
        fontWeight: FontWeight.w300,
        fontFamily: "sans-serif",
    ),
    );
  }
}
