import 'package:flutter/material.dart';
import '../dto/dtobarrel.dart';
import './screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class MinistryScreen extends StatefulWidget {
  const MinistryScreen({super.key});

  @override
  State<MinistryScreen> createState() => _MinistryScreenState();
}

class _MinistryScreenState extends State<MinistryScreen> {
  final MinistriesData ministriesData = MinistriesData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Our Church'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\n Read the word \n',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                child: const Card(
                  child: ListTile(
                    title: Text(
                      'BIBLE',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) {
                    return const BibleScreen();
                  }));
                },
              ),
              const Text(
                '\n Church Ministries \n',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                child: const Card(
                  child: ListTile(
                    title: Text(
                      'KIDS',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) {
                    return const KidsMinistry();
                  }));
                },
              ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   padding: const EdgeInsets.all(1),
              //   itemCount: ministriesData.ministries.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return InkWell(
              //       child: Card(
              //         child: Padding(
              //           padding:
              //               const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
              //           child: Text(
              //             ministriesData.ministries[index].church,
              //             style: const TextStyle(
              //               fontSize: 17.0,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.black54,
              //             ),
              //           ),
              //         ),
              //       ),
              //       onTap: () {
              //         Navigator.of(context).push(MaterialPageRoute<dynamic>(
              //             builder: (BuildContext context) {
              //           return Ministry(
              //               ministry: ministriesData.ministries[index]);
              //         }));
              //       },
              //     );
              //   },
              // ),
              FutureBuilder<QuerySnapshot>(
                future: ministriesData.ministriesDb.get(),
                builder: (BuildContext context,  snapshot){
                  if (snapshot.hasData) {

                    final List<DocumentSnapshot> documents = snapshot.data!.docs;
                    if(documents.isEmpty){
                      return const Center(child: Text(" Other Ministries not uploaded yet!!!",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),));
                    }

                    return ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: documents
                            .map((doc) =>

                            Card(
                              child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                                  child: Text(
                                    doc['church'],
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) {
                                        return Ministry(ministry: doc);
                                      }
                                      )
                                  );
                                },
                              ),
                            )).toList()
                    );

                  }else if (snapshot.hasError) {
                    return const Center(child: Text("An Error Occurred!",style: TextStyle(
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
            ],
          ),
        ));
  }
}

class Ministry extends StatelessWidget {
  const Ministry({super.key, required this.ministry});
  final DocumentSnapshot ministry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(ministry['church']),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Center(
                    child: Text(
                  '${ministry['church']}\'s Ministry',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Under the Leadership of ${ministry['leaders']} ',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    for (var item in ministry['paragraphs'] ?? [])
                      Text(
                        '\n $item',
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    const Text('\n'),
                    // Text(
                    //   '${ministry.church} is located at:',
                    //   style: const TextStyle(
                    //     fontSize: 12.0,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.black54,
                    //   ),
                    // ),
                    // for (var item in ministry.address)
                    //   Text(
                    //     item,
                    //     style: const TextStyle(
                    //       fontSize: 12.0,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black54,
                    //     ),
                    //   ),
                    Text(
                      'Contact ${ministry['church']} Ministry :',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    for (var item in ministry['contacts'])
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    // const Text('\n'),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class KidsMinistry extends StatefulWidget {
  const KidsMinistry({super.key});

  @override
  State<KidsMinistry> createState() => _KidsMinistryState();
}

class _KidsMinistryState extends State<KidsMinistry> {
  KidsStreamData kidsData = KidsStreamData();
  late String videoTitle;
  bool streamReady=false;
  List<String> streamUlr =[];

  List<YoutubePlayerController> lStreamScreenC = [];

  Map<String, dynamic> cStates = {};

  @override
  void initState() {
    super.initState();

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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('KIDS MINISTRY'),
          automaticallyImplyLeading: false,
        ),
        body:
        FutureBuilder<QuerySnapshot>(
          future: kidsData.kidsStreamDb.get(),
          builder: (BuildContext context,  snapshot){
            if (snapshot.hasData) {

              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              if(documents.isEmpty){
                return const Center(child: Text("Kids Stream Data Not Uploaded yet!!",style: TextStyle(
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
