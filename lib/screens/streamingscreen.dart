import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../dto/streamDto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({Key? key}) : super(key: key);

  @override
  _StreamScreenState createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  SermonStreamData sermonData = SermonStreamData();
  late Future<QuerySnapshot> sermonDbCall;
  late String videoTitle;
   bool streamReady=false;
   List<String> streamUlr =[];

  List<YoutubePlayerController> lStreamScreenC = [];

  Map<String, dynamic> cStates = {};

  @override
  void initState() {
    super.initState();
    sermonDbCall = sermonData.sermonStreamDb.get(const GetOptions(source: Source.serverAndCache));

  //   const GetOptions(source : Source.cache)
  }


  @override
  void dispose() {
    for (var element in lStreamScreenC) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streaming'),
        automaticallyImplyLeading: false,
      ),
      body:
      FutureBuilder<QuerySnapshot>(
        future: sermonDbCall,
        builder: (BuildContext context,  snapshot){
          if (snapshot.hasData) {

            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            if(documents.isEmpty){
              return const Center(child: Text("No Sermon Data",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),));
            }
            for(var url in documents){
              streamUlr.add(url['url']);
                String id;
                YoutubePlayerController streamScreenController;
                  id = YoutubePlayer.convertUrlToId(url['url'])!;
                  streamScreenController = YoutubePlayerController(
                  initialVideoId: id,
                  flags: const YoutubePlayerFlags(
                  autoPlay: false,
                  enableCaption: true,
                  captionLanguage: 'en',
                  ),
                );

                streamScreenController.addListener(() {
                    if(streamScreenController.value.isReady){
                      streamReady = true;
                    }
                    if (cStates[id] != streamScreenController.value.isPlaying) {
                      if (mounted) {
                       setState(() {
                        cStates[id] = streamScreenController.value.isPlaying;
                        // print(streamScreenController.metadata.title);
                      });
                      }
                    }
                });

                lStreamScreenC.add(streamScreenController);
            }
            return   Padding(
              padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: documents.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                  YoutubePlayerController streamScreenController =
                      lStreamScreenC[index];
                  String id = YoutubePlayer.convertUrlToId(streamUlr[index])!;
                  String curState = 'undefined';
                  if (cStates[id] != null) {
                    curState = cStates[id] ? 'playing' : 'paused';
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 250.0,
                          decoration: const BoxDecoration(
                            color: Color(0xfff5f5f5),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            child: YoutubePlayer(
                              controller: streamScreenController,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.lightBlueAccent,
                              bottomActions: [
                                CurrentPosition(),
                                ProgressBar(isExpanded: true),
                                FullScreenButton(),
                              ],
                              onReady: () {
                                // print('onReady for $index');
                              },
                              onEnded: (YoutubeMetaData _md) {
                                streamScreenController.seekTo(
                                    const Duration(seconds: 0));
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child: Text(
                            curState,
                            textScaleFactor: 1.5,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );


          }else if (snapshot.hasError) {
            return const Center(child: Text("It's Error!",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),));
          }

          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Loading...',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          );


        },
      )


    );
  }
}
