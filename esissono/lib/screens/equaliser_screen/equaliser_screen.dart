import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:audio_session/audio_session.dart';
import 'package:esissono/screens/equaliser_screen/sections/common.dart';
import 'package:esissono/screens/equaliser_screen/sections/equalize.dart';
import 'package:esissono/screens/equaliser_screen/sections/micro.dart';
import 'package:esissono/screens/equaliser_screen/sections/player_section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../utils/couleur.dart';
import '../../utils/dimensions.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../widgets/BigText.dart';




class EqualizerScreen extends StatefulWidget {
  final index;
  const EqualizerScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<EqualizerScreen> createState() => _EqualizerScreenState();
}

class _EqualizerScreenState extends State<EqualizerScreen> with WidgetsBindingObserver {
  final _player = AudioPlayer();


  int _currentIndex = 0;
  bool isLoading = true;
  bool equipeStarting = Random().nextBool();

  var boxLocal ;
  var boxWifi;


  List<dynamic> listLocal = [];



  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  String getSongFilePath(String uri) {
    // Convert the URI to a File object.
    final file = File.fromUri(Uri.parse(uri));

    // Return the file path.
    return file.path;
  }


  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }


  Future<void> _init() async {

    boxLocal = await Hive.openBox('local');


    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    // Try to load audio from a source and catch any errors.
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await _player.setAudioSource(AudioSource.uri(Uri.parse(
          "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
    } catch (e) {
      kShowSnackBar(context, "Impossible de lire le son");
    }
  }

  Future<SongModel> callback(SongModel song) async {
    // Get the song's URI.

      final uri = song.uri;

      // Get the song's file path.
      //final filePath = getSongFilePath(uri!);
      // Try to load audio from a source and catch any errors.
      try {
        // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
        await _player.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      } catch (e) {
        kShowSnackBar(context, "impossible de lire le son");
      }

      return song;
  }


  @override
  Widget build(BuildContext context) {

    Timer(
        const Duration(seconds: 4), (){
        setState(() {
          listLocal = boxLocal.get("listLocal");
        });

    });

    return Scaffold(
      body: SafeArea(
        child: listLocal.isNotEmpty?Column(
          children: [
            Container(
              height: Dimensions.height / 6,
              width: Dimensions.width,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: Dimensions.height / 6,
                      width: Dimensions.width,
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(Dimensions.d20),
                              bottomRight: Radius.circular(Dimensions.d20)
                          ),
                        image : DecorationImage(
                          image: AssetImage("assets/images/sono_.jpg"),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children : [
                        Padding(
                          padding: EdgeInsets.only(left: Dimensions.w10, top: Dimensions.d10),
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child:Container(
                              padding: EdgeInsets.all(Dimensions.d05),
                              decoration: BoxDecoration(
                                color: Couleur.secondarColor,
                                borderRadius: BorderRadius.circular(Dimensions.d20),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      spreadRadius: 2
                                  )
                                ],
                              ),
                              child: Icon(Icons.arrow_back_ios_new, size: Dimensions.d20, color: Couleur.primaryColor,),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: Dimensions.w105,
                          child: SwitchListTile(
                            secondary: Icon(equipeStarting?Icons.power_off:Icons.power, color: Couleur.secondarColor,),
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.red,
                            value: equipeStarting, onChanged: (val) {
                            setState(() {
                              equipeStarting = val;
                            });
                          }),
                        )

                      ]
                  ),
                  Positioned(
                      bottom: Dimensions.h10,
                      width: Dimensions.width ,
                      child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [BigText(text: listLocal[widget.index].nomLocal)]))
                ],
              ),
            ),
            equipeStarting?Expanded(
              child: SingleChildScrollView(
                  child: [PlayerSection(player: _player, positionDataStream: _positionDataStream,  callback: callback,), Equalize(player: _player), MicroScreen()][_currentIndex],
                ),
            ):Container(
              padding: EdgeInsets.only(top: Dimensions.h40),

              child: Column(
                children: [
                  SwitchListTile(
                    title: BigText(text: "l'equipement est etient , veillez l'allumer", size: Dimensions.d18, color: Couleur.primaryColor,),
                    value: equipeStarting,
                    inactiveThumbColor: Colors.red,
                    activeColor: Colors.green,
                    onChanged: (bool value) {
                      setState(() {
                        equipeStarting = value;
                      });
                    },

                  ),
                  Container(
                    height: Dimensions.h200,
                    width: Dimensions.w250,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.w20),
                        image: const DecorationImage(
                            image:AssetImage("assets/images/offline.jpg"), fit: BoxFit.cover
                        )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ):Center(child: CircularProgressIndicator(),),
      ),
      bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Couleur.primaryColor,
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
              SalomonBottomBarItem(
              icon: Icon(Icons.info_outline, color: Couleur.primaryColor,),
              title: Text("info"),
              selectedColor: Colors.blue,
            ),

              /// Likes
              SalomonBottomBarItem(
              icon: Icon(Icons.equalizer, color: Couleur.primaryColor),
              title: Text("reglage"),
              selectedColor: Colors.blue,
              ),          /// Likes
              SalomonBottomBarItem(
              icon: Icon(Icons.mic_rounded, color: Couleur.primaryColor),
              title: Text("micro"),
              selectedColor: Colors.blue,
              )

              ]),
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