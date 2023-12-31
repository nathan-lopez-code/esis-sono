import 'package:esissono/widgets/BigText.dart';
import 'package:esissono/widgets/smalText.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../utils/couleur.dart';
import '../../../utils/dimensions.dart';


class Songs extends StatefulWidget {

  Function callback;
  Songs({Key? key, required this.callback}) : super(key: key);

  @override
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  // Main method.
  final OnAudioQuery _audioQuery = OnAudioQuery();

  // Indicate if application has permission to the library.
  bool _hasPermission = false;
  bool tryPlay = false;
  var currentPlayed = null;

  List<SongModel> played = [];

  @override
  void initState() {
    super.initState();
    // (Optinal) Set logging level. By default will be set to 'WARN'.
    //
    // Log will appear on:
    //  * XCode: Debug Console
    //  * VsCode: Debug Console
    //  * Android Studio: Debug and Logcat Console
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioQuery.setLogConfig(logConfig);

    // Check and request for permission.
    checkAndRequestPermissions();
  }

  checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    _hasPermission ? setState(() {}) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: !_hasPermission
            ? noAccessToLibraryWidget()
            : FutureBuilder<List<SongModel>>(
            // Default values:
            future: _audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),
            builder: (context, item) {
              // Display error, if any.
              if (item.hasError) {
                return Text(item.error.toString());
              }

              // Waiting content.
              if (item.data == null) {
                return const CircularProgressIndicator();
              }

              // 'Library' is empty.
              if (item.data!.isEmpty) return const Text("Nothing found!");

              // You can use [item.data!] direct or you can create a:
              // List<SongModel> songs = item.data!;
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: item.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: Dimensions.h100,
                    margin: EdgeInsets.symmetric(vertical: Dimensions.h05),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w10, vertical: Dimensions.h10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: Dimensions.h20,
                              foregroundColor: Couleur.primaryColor,
                              child: Icon(Icons.headphones, size: Dimensions.d20, color: Couleur.primaryColor),
                            ),
                            SizedBox(
                              width: Dimensions.w20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Dimensions.width/1.9,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              BigText(
                                                  text: item.data![index].title,
                                                  color: Couleur.primaryColor,
                                                  size: Dimensions.d15
                                              ),

                                              SizedBox(height: Dimensions.h05,),
                                              SmallText(
                                                  text: item.data![index].artist != null?"Artiste : ${ item.data![index].artist}":"Artiste : inconnu",
                                                  color: Couleur.primaryColor,
                                                  size: Dimensions.d12
                                              )
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.w10,),
                                    GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            currentPlayed = widget.callback(item.data![index]);

                                          });

                                        },
                                        child: currentPlayed != null? currentPlayed == item.data![index]?Icon(Icons.play_arrow, color: Couleur.primaryColor, size: Dimensions.w30,):Icon(Icons.play_circle, color: Couleur.primaryColor, size: Dimensions.w30,)
                                              :Icon(Icons.play_circle, color: Couleur.primaryColor, size: Dimensions.w30,)
                                    )

                                  ],
                                ),
                                SizedBox(height: Dimensions.h20,),
                                Container(
                                  height: 1,
                                  width: Dimensions.width - 90,
                                  color: Couleur.primaryColor,
                                  //child: Text("hello"),
                                )
                              ],
                            )
                          ],
                        ),

                      ],
                    ),
                    /*title: Text(item.data![index].title),
                    subtitle: Text(item.data![index].artist ?? "No Artist"),
                    trailing: const Icon(Icons.arrow_forward_rounded),
                    // This Widget will query/load image.*/
                    // You can use/create your own widget/method using [queryArtwork].
                  );
                },
            );
          },
        ),
      );
  }

  Widget noAccessToLibraryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => checkAndRequestPermissions(retry: true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }
}