import 'package:equalizer_flutter/equalizer_flutter.dart';
import 'package:equalizer_flutter_custom/src/EqalizerProvider/EqualizerProvider.dart';
import 'package:equalizer_flutter_custom/src/CustomSlider.dart';
import 'package:equalizer_flutter_custom/src/Customeq.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../utils/couleur.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/BigText.dart';

class MyCustomEqualizerer extends StatefulWidget {
  const MyCustomEqualizerer(
      {super.key,
        required this.playerSessionId,
        this.sliderBoxHeight,
        this.sliderBoxBackgroundColor,
        this.sliderBoxBorderRadius,
        this.inactiveTrackBar,
        this.midPointBgColor,
        this.midPointColorActive,
        this.midPointColorInactive,
        this.midPointIcon,
        this.activeDisabledTrackBarColor,
        this.inactiveDisabledTrackBarColor,
        this.activeTrackBarMaxColor,
        this.activeTrackBarMinColor,
        this.dragIndicatorActiveColor,
        this.dragIndicatorInactiveColor,
        this.bandTextColor,
        this.bandTextFontSize,
        this.presetsStyle,
        this.presetsBoxDecoration,
        this.baseTextColor,
        this.customSwitch,
        required this.isEqEnabled,
        this.actionsIconTheme,
        this.appBarBgColor,
        this.appBarLeading,
        this.appBarShadowColor,
        this.appBarTitle,
        this.appbarElevation,
        this.automaticallyImplyLeading,
        this.titleTextStyle,
        this.inActiveSwitchTrackColor,
        this.activeSwitchTrackColor,
        this.activeSwitchColor,
        this.bgColor,
        this.sliderBoxPadding});

  final int playerSessionId;

  final double? sliderBoxHeight;
  final Color? sliderBoxBackgroundColor;
  final BorderRadius? sliderBoxBorderRadius;
  final Color? inactiveTrackBar;
  final Color? midPointBgColor;
  final Color? midPointColorActive;
  final Color? midPointColorInactive;
  final IconData? midPointIcon;
  final Color? activeDisabledTrackBarColor;
  final Color? inactiveDisabledTrackBarColor;
  final Color? activeTrackBarMaxColor;
  final Color? activeTrackBarMinColor;
  final Color? dragIndicatorActiveColor;
  final Color? dragIndicatorInactiveColor;
  final Color? bandTextColor;
  final double? bandTextFontSize;
  final TextStyle? presetsStyle;
  final BoxDecoration? presetsBoxDecoration;
  final Color? baseTextColor;
  final Widget? customSwitch;
  final bool isEqEnabled;
  final Color? appBarShadowColor;
  final String? appBarTitle;
  final IconThemeData? actionsIconTheme;
  final bool? automaticallyImplyLeading;
  final Color? appBarBgColor;
  final double? appbarElevation;
  final Widget? appBarLeading;
  final TextStyle? titleTextStyle;
  final Color? inActiveSwitchTrackColor;
  final Color? activeSwitchTrackColor;
  final Color? activeSwitchColor;
  final Color? bgColor;

  final double? sliderBoxPadding;

  @override
  State<MyCustomEqualizerer> createState() => _MyCustomEqualizererState();
}

class _MyCustomEqualizererState extends State<MyCustomEqualizerer> {
  @override
  void initState() {
    // TODO: implement initState
    iniaudio();
    super.initState();
    // EqualizerFlutter.setAudioSessionId(widget.PlayerSessionId);

    WidgetsBinding.instance.addPostFrameCallback((_) => deffun());
  }

  iniaudio() async {
    await EqualizerFlutter.init(widget.playerSessionId);
    context.read<EqualizerProvider>().setEqEnabled(widget.isEqEnabled);
    await context.read<EqualizerProvider>().getPresest();
  }

  deffun() async {
    // if (context.read<EqualizerProvider>().isEqEnabled) {

    context.read<EqualizerProvider>().setEqEnabled(widget.isEqEnabled);
    // }
  }

  String dropdownValue = 'Dog';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.appBarTitle ?? "Equalizer", style: TextStyle(
            fontSize: Dimensions.d20,
          ), textAlign: TextAlign.center,),
          shadowColor: widget.appBarShadowColor,
          actionsIconTheme: widget.actionsIconTheme,
          automaticallyImplyLeading: widget.automaticallyImplyLeading ?? true,
          backgroundColor:
          widget.appBarBgColor ?? globalThemes.colors2['bgColor'],
          elevation: widget.appbarElevation,
          leading: widget.appBarLeading,
        ),
        body: Container(
          decoration: BoxDecoration(
              color: widget.bgColor ?? globalThemes.colors2['bgColor']
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: EqualizerFlutter.getBandLevelRange(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Customeq(
                              snapshot.data![0].toDouble(),
                              snapshot.data![1].toDouble(),
                              widget.sliderBoxHeight,
                              widget.sliderBoxBackgroundColor,
                              widget.sliderBoxBorderRadius,
                              widget.inactiveTrackBar,
                              widget.midPointBgColor,
                              widget.midPointColorActive,
                              widget.midPointColorInactive,
                              widget.midPointIcon,
                              widget.activeDisabledTrackBarColor,
                              widget.inactiveDisabledTrackBarColor,
                              widget.activeTrackBarMaxColor,
                              widget.activeTrackBarMinColor,
                              widget.dragIndicatorActiveColor,
                              widget.dragIndicatorInactiveColor,
                              widget.bandTextColor,
                              widget.bandTextFontSize,
                              widget.sliderBoxPadding);
                        } else {
                          return const Text("AudioSessinId Not Found");
                        }
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  )),
              SizedBox(height: Dimensions.h20,),
              Container(
                color: Couleur.secondarColor,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: Dimensions.w10, right: Dimensions.w10, top: Dimensions.h10, bottom: Dimensions.h10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Consumer<EqualizerProvider>(
                          builder: (context, value, child) {
                            return value.isEqEnabled
                                ? SleekCircularSlider(
                              min: 0,
                              max: 1000,
                              initialValue: value.bassval,
                              onChangeEnd: (val) {
                                value.setbassval(val);
                              },
                              appearance: CircularSliderAppearance(
                                  customColors: CustomSliderColors(
                                    dotColor: Couleur.primaryColor,
                                    dynamicGradient: true,
                                    progressBarColor: Couleur.primaryColor,
                                    trackColor: Couleur.secondarColor,
                                    hideShadow: true,

                                  )),
                            )
                                : SleekCircularSlider(
                              min: 0,
                              max: 1000,
                              initialValue: value.bassval,
                              appearance: CircularSliderAppearance(
                                  customColors: CustomSliderColors(
                                    dotColor: Colors.blueAccent,
                                    dynamicGradient: false,
                                    progressBarColor: Colors.blueAccent,
                                    trackColor: Colors.blueAccent,
                                  )),
                            );
                          },
                        ),
                        Text(
                          "Base",
                          style: TextStyle(
                              fontSize: Dimensions.d17,
                              color: widget.baseTextColor ??
                                  globalThemes.colors2['textColor2']),

                        )
                      ],
                    ),
                    Consumer<EqualizerProvider>(
                      builder: (context, value, child) {
                        print(value.currentp);
                        return FutureBuilder(
                            future: value.getPresest(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  decoration: widget.presetsBoxDecoration,
                                  width: Dimensions.w80,
                                  child: IgnorePointer(
                                    ignoring: !value.isEqEnabled,
                                    child: DropdownButton<String>(
                                      // Step 3
                                      // .
                                      alignment: Alignment.center,
                                      isExpanded: true,

                                      value: value.currentp,

                                      // Step 4.

                                      items: snapshot.data!
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: widget.presetsStyle ??
                                                     TextStyle(
                                                      fontSize: Dimensions.d15,
                                                      color: Couleur.primaryColor,
                                                    ),
                                              ),
                                            );
                                          }).toList(),
                                      onChanged: (v) {
                                        value.setPresets(v);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
