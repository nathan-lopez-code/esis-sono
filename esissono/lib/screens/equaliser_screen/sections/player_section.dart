import 'package:flutter/material.dart';
import '../../../utils/couleur.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/BigText.dart';
import '../../../widgets/smalText.dart';
import 'common.dart';
import 'controler_button.dart';
import 'list_audio.dart';




class PlayerSection extends StatefulWidget {
  
  final player;
  final Stream<PositionData>? positionDataStream;
  final Function callback;

  const PlayerSection({Key? key, required this.player, required this.positionDataStream, required this.callback}) : super(key: key);

  @override
  State<PlayerSection> createState() => _PlayerSectionState();
}

class _PlayerSectionState extends State<PlayerSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: Dimensions.h05),
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w10, vertical: Dimensions.h05),
          height: Dimensions.h160,
          width: double.maxFinite,
          decoration : BoxDecoration(
            color: Couleur.white,
          ),
          child: Column(
            children: [
              Center(child: SmallText(text: 'Tester le son', size: Dimensions.d15, color: Couleur.primaryColor,)),
              SizedBox(height: Dimensions.h05,),

              ControlButtons(widget.player),

              StreamBuilder<PositionData>(
                stream: widget.positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                    positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: widget.player.seek,
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h10,),
        BigText(text: "Liste Audio", size: Dimensions.d17, color: Couleur.primaryColor,),
        SizedBox(height: Dimensions.h10,),
        SizedBox(
            height: Dimensions.height,
            child: Songs(callback: widget.callback,)
        )
      ],
    );
  }
}
